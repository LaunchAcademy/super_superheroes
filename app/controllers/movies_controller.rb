class MoviesController < ApplicationController
  include RottenTomatoes

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @movies = Movie.all.page(params[:page])
  end

  def new
    @movie = Movie.new
  end


  def create
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
    @reviews = Kaminari.paginate_array(@movie.reviews.sort_by(&:net_votes).reverse!).page(params[:page]).per(10)
    # @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      flash[:notice] = "Movie successfully Deleted"
    else
      flash[:alert] = "Movie could not be Deleted"
    end

    redirect_to movies_path
  end


  def search
    Rotten.api_key = ENV['rotten_key']
    key_word = params[:q]
    @response = RottenMovie.find(title: key_word)

    if @response.blank?
      redirect_to new_movie_path, notice: "No movies found!"
    else
      movie = @response[0]
      new_movie = Movie.new(title: movie.title, year: movie.year.to_s, synopsis: movie.synopsis, mpaa_rating: movie.mpaa_rating, director: movie.director, superhero: key_word, user: current_user)

      if new_movie.save
        flash[:notice] = 'Success! Your movie was saved.'
        redirect_to movie_path(new_movie)
      else
        flash[:notice] = "Unable to save movie. Try again later!"
        render 'new'
      end
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :year, :superhero, :mpaa_rating, :synopsis, :director).merge(user: current_user)
  end
end
