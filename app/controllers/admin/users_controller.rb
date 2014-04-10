module Admin
  class UsersController < ApplicationController
    before_action :validate_admin

    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])

      if @user.destroy
        flash[:notice] = 'User successfully deleted.'
      else
        flash[:alert] = 'User was not deleted.'
      end

      redirect_to admin_users_path
    end
  end
end
