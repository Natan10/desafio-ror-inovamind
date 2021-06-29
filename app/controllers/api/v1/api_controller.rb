module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_user

      private

      def token_request
        if request.headers["Authorization"].nil?
          return nil
        end
        request.headers["Authorization"].split(" ")[1]
      end

      def authenticate_user
        user_id = AuthenticationTokenService.decode(token_request)
        @current_user = User.find(user_id["user_id"])
        @current_user
      rescue Mongoid::Errors::DocumentNotFound, JWT::ExpiredSignature,JWT::DecodeError
        head :unauthorized
      end
    end
  end
end
