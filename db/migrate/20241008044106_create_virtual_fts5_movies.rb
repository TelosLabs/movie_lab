class CreateVirtualFts5Movies < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      CREATE VIRTUAL TABLE fts_movies
      USING fts5(title,overview)
    SQL
  end

  def down
    execute <<~SQL
      DROP TABLE fts_movies;
    SQL
  end
end
