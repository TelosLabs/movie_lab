# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_10_08_192553) do
# Could not dump table "movie_vectors_vector_chunks00" because of following StandardError
#   Unknown type '' for column 'rowid'


  create_table "movies", force: :cascade do |t|
    t.bigint "tmdb_id", null: false
    t.string "title", null: false
    t.string "poster_url"
    t.text "overview"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true
  end

  # Virtual tables defined in this database.
  # Note that virtual tables may not work with other database engines. Be careful if changing database.
  create_virtual_table "movie_fts", "fts5", ["title", "overview"]
  create_virtual_table "movie_vectors", "vec0", ["movie_id integer primary key", "embedding float[1536] distance_metric=cosine"]
end
