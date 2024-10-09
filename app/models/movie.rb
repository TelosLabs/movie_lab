# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  embedding  :binary
#  overview   :text
#  poster_url :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tmdb_id    :bigint           not null
#
# Indexes
#
#  index_movies_on_tmdb_id  (tmdb_id) UNIQUE
#
class Movie < ApplicationRecord
  include FullTextSearch
  include VectorSearch

  def unpacked_embedding = embedding.unpack("f*")

  def full_poster_path
    "https://media.themoviedb.org/t/p/w220_and_h330_face/#{poster_url}"
  end

  def generate_and_save_embedding
    return if embedding.present?

    self.embedding = Embedding.create(overview).pack("f*")
    save!
  end
end
