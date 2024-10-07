class Movie < ApplicationRecord
  include MeiliSearch::Rails

  meilisearch do
    attribute :title
  end

  def full_poster_path
    "https://media.themoviedb.org/t/p/w220_and_h330_face/#{poster_url}"
  end
end
