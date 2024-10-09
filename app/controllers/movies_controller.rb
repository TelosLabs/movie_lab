class MoviesController < ApplicationController
  def index
    @movies =
      if params[:search].present?
        # Movie.where("title LIKE ?", "%#{params[:search]}%").limit(100)
        Movie.vector_search(input: params[:search], limit: 20)
      else
        Movie.all.limit(100)
      end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
