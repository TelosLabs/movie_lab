class Movie < ApplicationRecord
  def self.vector_search(input:, limit: 8)
    input_embedding = Embedding.create(input)
    response = ActiveRecord::Base.connection.execute(
      "SELECT rowid, distance
      FROM vec_movies
      WHERE embedding match '#{input_embedding}'
      ORDER BY distance
      LIMIT #{limit};"
    )
    # TODO order
    where(id: response.map { |r| r["rowid"] })
  end

  def unpacked_embedding = embedding.unpack("f*")

  def full_poster_path
    "https://media.themoviedb.org/t/p/w220_and_h330_face/#{poster_url}"
  end

  def generate_and_save_embedding
    return if embedding.present?

    self.embedding = Embedding.create(overview).pack("f*")
    save!
  end

  def find_or_create_vec_movie
    vec_movie = ActiveRecord::Base.connection.execute(
      "SELECT * FROM vec_movies WHERE rowid = #{id}"
    ).first
    return if vec_movie.present?

    ActiveRecord::Base.connection.execute(
      "INSERT INTO vec_movies (rowid, embedding) VALUES (#{id}, '#{unpacked_embedding}')"
    )
  end

  def similar(n = 8)
    response = ActiveRecord::Base.connection.execute(
      "SELECT rowid, distance
      FROM vec_movies
      WHERE embedding match '#{unpacked_embedding}'
      ORDER BY distance
      LIMIT #{n + 1};"
    )
    Movie
      .where(id: response.map { |r| r["rowid"] })
      .where.not(id: id)
  end
end
