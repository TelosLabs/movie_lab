class CreateVirtualMovieVectors < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :movie_vectors, :vec0, [
      "movie_id integer primary key",
      "embedding float[1536] distance_metric=cosine"
    ]
  end
end
