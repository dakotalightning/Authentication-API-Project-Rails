class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/{username}
  def show
    render json: @user.to_json(only: [:username]), status: :ok
  end

  private

    def user_params
      params.permit(:username, :password)
    end

    def set_user
      @user = User.find(params[:username])
    end

end
