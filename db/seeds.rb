list_searches = [
  proc { Tmdb::Movie.popular },
  proc { Tmdb::Movie.top_rated }
]
list_searches.each do |search|
  movie_attrs = []
  search.call.results.each do |movie|
    movie_attrs << {
      tmdb_id: movie.id,
      title: movie.title,
      overview: movie.overview,
      poster_url: movie.poster_path
    }
  end

  movie_attrs.uniq! { |movie| movie[:tmdb_id] }
  Movie.insert_all(movie_attrs)
end

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
Movie.insert_all(movie_attrs)

Movie.reindex!
