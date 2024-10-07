class MoviesController < ApplicationController
  def index
    @movies =
      if params[:search].present?
        Movie.search(params[:search], limit: 100)
      else
        Movie.all.limit(100)
      end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
