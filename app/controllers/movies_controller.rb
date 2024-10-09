class MoviesController < ApplicationController
  def index
    @movies =
      if params[:search_type] == "vector" && params[:search].present?
        Movie.vector_search(input: params[:search], limit: 40)
      elsif params[:search].present?
        Movie.full_text_search(input: params[:search], limit: 40)
      else
        Movie.all.limit(40)
      end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
