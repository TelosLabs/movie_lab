module Movie::VectorSearch
  extend ActiveSupport::Concern

  class_methods do
    def vector_search_sql(embedding, limit)
      <<~SQL
        SELECT rowid, distance
        FROM vec_movies
        WHERE embedding MATCH '#{embedding}'
        ORDER BY distance
        LIMIT #{limit};
      SQL
    end

    def vector_search_order_sql(ids)
      order_clause = ids
        .each_with_index
        .map { |id, index| "WHEN #{id} THEN #{index}" }
        .join(" ")
      Arel.sql("CASE id #{order_clause} END")
    end

    def vector_search(input:, limit: 8)
      input_embedding = Embedding.create(input)
      sql = vector_search_sql(input_embedding, limit)
      response = ActiveRecord::Base.connection.execute(sql)
      ids = response.map { |row| row["rowid"] }

      where(id: ids)
        .order(Movie.vector_search_order_sql(ids))
        .limit(limit)
    end
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
    sql = Movie.vector_search_sql(unpacked_embedding, n + 1)
    response = ActiveRecord::Base.connection.execute(sql)
    ids = response.map { |row| row["rowid"] }

    Movie
      .where(id: ids)
      .where.not(id: id)
      .order(Movie.vector_search_order_sql(ids))
      .limit(n)
  end
end
