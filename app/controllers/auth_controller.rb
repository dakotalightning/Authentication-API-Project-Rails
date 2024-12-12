class AuthController < ApplicationController

  skip_before_action :authenticate_request

  def token
    user = User.find(user_params[:username])

    if user&.authenticate(user_params[:password])
      auth_token = jwt_encode(username: user.username)
      render json: { token: auth_token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def register
    @user = User.new(user_params)

    if @user.save
      auth_token = jwt_encode(username: @user.username)
      render json: { token: auth_token }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
            status: :bad_request
    end
  end

  private

  def user_params
    params.require(:auth).permit(:username, :password)
  end

end
