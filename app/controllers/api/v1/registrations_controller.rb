module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      # include ExceptionHandler
      include ActAsApiRequest
      # include Localizable

      respond_to :json

      private

      def sign_up_params
        params.permit(:email, :password, :username )
      end

      def render_create_success
        render :create
      end

      def render_create_error
        render :error

      end

      def validate_post_data(which, message)
        render_errors(message, :bad_request) if which.empty?
      end
    end
  end
end
