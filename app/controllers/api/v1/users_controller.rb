module Api
  module V1
    class UsersController < Api::V1::ApiController
      helper_method :user

      before_action :require_check_if_changing_password, only: :update

      def show; end

      def update
        user.update!(user_params)
      end

      private

      def user
        @user ||= current_user
      end

      def require_check_if_changing_password
        return if !user_params[:password] || user.valid_password?(params[:password_check])

        render_errors(I18n.t('errors.authentication.invalid_password_check'), :bad_request)
      end

      def user_params
        params.permit(:email, :password, :first_name, :last_name, :username, :contact_number,  :store_name, :locale, :owner_name, :save_location_latitude, :save_location_longitude)
      end
    end
  end
end
