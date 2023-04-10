module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include ActAsApiRequest

      # include DeviseTokenAuth::Concerns::SetUserByToken
      # include Pagy::Backend

      # before_action :authenticate_user!


      def display_error(msg)
        render json: {api_status: false, error: msg}, status: 422
      end

      def display_success(msg)
        render json: {api_status: true,  success: msg}, status: 200
      end


    end
  end
end
