module Movie::VectorSearch
  extend ActiveSupport::Concern

  included do
    has_one :movie_vector
  end

  class_methods do
    def vector_search(embedding:, limit: 10)
      where("movie_vectors.embedding MATCH ? AND k = ?", embedding.to_s, limit)
        .joins(:movie_vector)
        .order("movie_vectors.distance")
        .distinct
    end
  end

  def similar(limit = 8)
    Movie
      .vector_search(embedding: movie_vector.embedding, limit: limit + 1)
      .where.not("movies.id = ?", id)
  end

  def find_or_create_movie_vector
    MovieVector.find_or_create_by!(movie_id: id) do |movie_vector|
      movie_vector.embedding = Embedding.create(overview).embedding
    end
  end
end
