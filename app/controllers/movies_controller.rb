class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def new
    if user_signed_in?
      @movie = Movie.new
    else
      redirect_to new_user_session_path, alert: 'You need to be signed in to add a movie.'
    end
  end

  def create
    @movie = Movie.new(movie_params.merge(user: current_user))
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
    @reviews = @movie.reviews.sort_by(&:net_votes).reverse!
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :superhero, :mpaa_rating, :synopsis, :director)
  end
end
