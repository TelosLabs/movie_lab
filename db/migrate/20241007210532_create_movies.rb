class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :poster_url
      t.text :overview
      t.bigint :tmdb_id, null: false
      t.timestamps

      t.index :tmdb_id, unique: true
    end
  end
end
