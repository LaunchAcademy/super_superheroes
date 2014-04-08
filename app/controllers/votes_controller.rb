class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    prior_vote = Vote.find_by(user: current_user, review: Review.find(params[:review_id]))

    if prior_vote
      prior_vote.destroy
    end

    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = "Success! You voted."
    else
      flash[:notice] = "Your vote could not be saved."
    end
    redirect_to movie_path(Movie.find_by(params[:id]))
  end

  private

  def vote_params
    params.permit(:value).merge(user: current_user,
      review: Review.find(params[:review_id]))
  end
end
