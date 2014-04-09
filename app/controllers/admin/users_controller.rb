module Admin
  class UsersController < ApplicationController
    before_action :validate_admin

    def index
      @users = User.all
    end
  end
end
