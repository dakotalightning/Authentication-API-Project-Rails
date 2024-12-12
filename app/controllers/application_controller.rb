class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

    def authenticate_request
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      if header.nil?
        render json: { error: "bad request" }, status: :bad_request
      else
        decoded = jwt_decode(header)
        render json: { error: "unauthorized" }, status: :unauthorized  unless @current_user = User.find(decoded [:username])
      end
    end

end
