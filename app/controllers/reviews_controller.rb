class ReviewsController < ApplicationController

  def index
    @movie = Movie.find(params[:movie_id])
    redirect_to movie_reviews_path(@movie)
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    if @review.save
      flash[:notice] = 'Success! Your review was saved.'
      redirect_to movie_path(@movie)
    else
      flash[:notice] = 'Review could not be saved.'
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
