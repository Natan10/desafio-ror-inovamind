module Api 
  module V1 
    class UserController < ApiController

      skip_before_action :authenticate_user, only: [:create]
      
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from Mongoid::Errors::Validations, with: :validation_error

      def create 
        @user = User.create!(user_params)
        head :created 
      end

      private 
      
      def user_params
        params.require(:user)
        .permit(:email, :password, :password_confirmation)
      end

      def parameter_missing(e)
        render json: {
          error: e.message
        }, status: :unprocessable_entity
      end

      def validation_error(e)
        render json: {
          error: e.message
        }, status: :unprocessable_entity
      end

    end 
  end 
end