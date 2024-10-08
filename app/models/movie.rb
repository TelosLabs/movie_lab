class Movie < ApplicationRecord
  include MeiliSearch::Rails

  meilisearch do
    attribute :title
  end

  def full_poster_path
    "https://media.themoviedb.org/t/p/w220_and_h330_face/#{poster_url}"
  end

  def generate_and_save_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: "text-embedding-3-small",
        input: overview
      }
    )
    self.embedding = response["data"][0]["embedding"]
    save!
  end
end
