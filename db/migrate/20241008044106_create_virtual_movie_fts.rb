class CreateVirtualMovieFts < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :movie_fts, :fts5, [
      "title",
      "overview"
    ]
  end
end
