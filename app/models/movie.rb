class Movie < ApplicationRecord
  include MeiliSearch::Rails

  meilisearch do
    attribute :title
  end
end
