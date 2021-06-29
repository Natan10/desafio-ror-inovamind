module Api
  module V1
    class AuthenticationController < ApiController
      class AuthError < StandardError; end

      skip_before_action :authenticate_user

      rescue_from AuthError, with: :handle_unauthenticated
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from Mongoid::Errors::DocumentNotFound, with: :verify_user

      def create
        @user = User.find_by(email: user_params[:email])
        raise AuthError unless @user.authenticate(user_params[:password])
        @token = AuthenticationTokenService.encode(@user.id.to_s)

        render :create, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def handle_unauthenticated
        head :unauthorized
      end

      def verify_user(e)
        render json: {
          error: e.message
        }, status: :not_found
      end

      def parameter_missing(e)
        render json: {
          error: e.message
        }, status: :unprocessable_entity
      end
    end
  end
end
