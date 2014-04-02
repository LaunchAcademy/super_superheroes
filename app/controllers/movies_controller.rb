class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = 'Success! Your movie was saved.'
      redirect_to movie_path(@movie)
    else
      flash[:notice] = 'Movie could not be saved'
      render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :superhero, :mpaa_rating, :synopsis, :director)
  end
end
