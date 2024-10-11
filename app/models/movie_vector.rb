class MovieVector < ApplicationRecord
  self.primary_key = "movie_id"

  has_neighbors :embedding, dimensions: 1536

  def movie = Movie.find(movie_id)
end
