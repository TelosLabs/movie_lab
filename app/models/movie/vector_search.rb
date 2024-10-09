module Movie::VectorSearch
  extend ActiveSupport::Concern

  class_methods do
    def vector_search(input:, limit: 8)
      input_embedding = Embedding.create(input)
      response = ActiveRecord::Base.connection.execute(
        "SELECT rowid, distance
        FROM vec_movies
        WHERE embedding MATCH '#{input_embedding}'
        ORDER BY distance
        LIMIT #{limit};"
      )
      ids = response.map { |row| row["rowid"] }
      where(id: ids)
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
    response = ActiveRecord::Base.connection.execute(
      "SELECT rowid, distance
      FROM vec_movies
      WHERE embedding MATCH '#{unpacked_embedding}'
      ORDER BY distance
      LIMIT #{n + 1};"
    )

    ids = response.map { |row| row["rowid"] }
    order_clause = ids
      .each_with_index
      .map { |id, index| "WHEN #{id} THEN #{index}" }
      .join(" ")
    Movie
      .where(id: ids)
      .where.not(id: id)
      .order(Arel.sql("CASE id #{order_clause} END"))
      .limit(n)
  end
end
