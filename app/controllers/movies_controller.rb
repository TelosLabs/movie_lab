class MoviesController < ApplicationController
  def index
    @movies =
      if params[:search].present?
        Movie.search(params[:search])
      else
        Movie.all
      end
  end
end
