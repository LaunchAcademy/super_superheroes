module Admin
  class MoviesController < ApplicationController
    before_action :admin?

    def index
      @movies = Movie.all
    end

    def destroy
      @movie = Movie.find(params[:id])

      if @movie.destroy
        flash[:notice] = "Movie successfully Deleted"
      else
        flash[:alert] = "Movie could not be Deleted"
      end

      redirect_to admin_movies_path
    end

    def show
    end

  end
end
