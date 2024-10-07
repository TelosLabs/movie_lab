movie_attrs = 1_000.times do
  {
    title: Faker::Movie.title,
    description: Faker::Movie.quote
  }
end

Movie.insert_all(movie_attrs)
