class VotesController < ApplicationController
  def create
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
