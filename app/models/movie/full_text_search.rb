module Movie::FullTextSearch
  extend ActiveSupport::Concern

  class_methods do
    def full_text_search(input:, limit:)
      sql = ActiveRecord::Base.sanitize_sql_array(
        ["SELECT rowid FROM fts_movies
          WHERE fts_movies MATCH ?
          LIMIT ?;", input, limit]
      )
      response = ActiveRecord::Base.connection.execute(sql)
      where(id: response.map { |r| r["rowid"] })
    end
  end

  def find_or_create_fts5_movie
    fts5_movie = ActiveRecord::Base.connection.execute(
      "SELECT rowid FROM fts_movies WHERE rowid = #{id}"
    ).first
    return if fts5_movie.present?

    sql = ActiveRecord::Base.sanitize_sql_array(
      ["INSERT INTO fts_movies (rowid, title, overview) VALUES (?, ?, ?)", id, title, overview]
    )
    ActiveRecord::Base.connection.execute(sql)
  end
end
