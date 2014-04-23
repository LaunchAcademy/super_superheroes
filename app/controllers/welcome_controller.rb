class WelcomeController < ApplicationController
  def index
    @reviews = Review.order(created_at: :desc).limit(10)
  end
end
