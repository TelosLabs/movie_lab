list_searches = [
  proc { Tmdb::Movie.popular },
  proc { Tmdb::Movie.top_rated }
]
movie_attrs = []
list_searches.each do |search|
  search.call.results.each do |movie|
    movie_attrs << {
      tmdb_id: movie.id,
      title: movie.title,
      overview: movie.overview,
      poster_url: movie.poster_path
    }
  end
end
Movie.insert_all(movie_attrs, unique_by: :tmdb_id)

movie_attrs = []
genres = Tmdb::Genre.movie_list
genres.each do |genre|
  # Get the first 5 pages of movies for each genre (each page contains 20 movies)
  1.upto(5) do |page|
    Tmdb::Genre.movies(genre.id, page:).results.each do |movie|
      movie_attrs << {
        tmdb_id: movie.id,
        title: movie.title,
        overview: movie.overview,
        poster_url: movie.poster_path
      }
    end
  end
end
movie_attrs.uniq! { |movie| movie[:tmdb_id] }
Movie.insert_all(movie_attrs, unique_by: :tmdb_id)

Movie.all.find_each do |movie|
  movie.generate_and_save_embedding
  movie.find_or_create_vec_movie
end
