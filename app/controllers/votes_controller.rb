class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = "Success! You voted."
    else
      flash[:notice] = "Your vote could not be saved."
    end
    redirect_to movie_path(@vote.review.movie)
  end

  def update
    @review = Review.find(params[:review_id])
    @vote = Vote.find_by(review: @review, user: current_user)
    if @vote.update(vote_params)
      flash[:notice] = "Success! You changed your vote."
    else
      flash[:notice] = "Your vote could not be saved."
    end
    redirect_to movie_path(@review.movie)
  end

  private

  def vote_params
    params.permit(:value).merge(user: current_user,
      review: Review.find(params[:review_id]))
  end
end
