class CreateVirtualMoviesVector < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      CREATE VIRTUAL TABLE vec_movies
      USING vec0(embedding float[1536]);
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE vec_movies;
    SQL
  end
end
