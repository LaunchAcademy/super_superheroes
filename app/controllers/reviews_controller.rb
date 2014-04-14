class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @movie = Movie.find(params[:movie_id])
    redirect_to movie_path(@movie)
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

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    if @review.update(review_params) && current_user == @review.user
      flash[:notice] = 'Success! Your review was saved.'
      redirect_to movie_path(@movie)
    else
      flash[:notice] = 'Review could not be saved.'
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])

    if @review.destroy
      flash[:notice] = 'Review successfully deleted.'
    else
      flash[:notice] = 'Review could not be deleted.'
    end

    redirect_to movie_path(@movie)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body).merge(user: current_user)
  end
end
