module Movie::FullTextSearch
  extend ActiveSupport::Concern

  included do
    has_one :movie_fts, foreign_key: "rowid"
  end

  class_methods do
    def full_text_search(input:, limit:)
      where("movie_fts MATCH ?", input)
        .joins(:movie_fts)
        .limit(limit)
        .distinct
    end
  end

  def find_or_create_movie_fts
    return if movie_fts

    sql = ActiveRecord::Base.sanitize_sql_array(
      [
        "INSERT INTO movie_fts (rowid, title, overview) VALUES (?, ?, ?)",
        id, title, overview
      ]
    )
    ActiveRecord::Base.connection.execute(sql)
  end
end
