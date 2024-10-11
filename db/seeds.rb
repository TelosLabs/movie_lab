list_searches = [
  proc { Tmdb::Movie.popular },
  proc { Tmdb::Movie.top_rated }
]
movie_attrs = []
list_searches.each do |search|
  search.call.results.each do |movie| # Each list contains 20 movies
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
  1.upto(5) do |page| # Each page contains 20 movies
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
Movie.insert_all(movie_attrs, unique_by: :tmdb_id)

Movie.find_each do |movie|
  movie.find_or_create_movie_fts
  movie.find_or_create_movie_vector
end
