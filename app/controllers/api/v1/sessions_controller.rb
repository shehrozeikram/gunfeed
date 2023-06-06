module Api
  module V1
    class SessionsController < Devise::SessionsController
      include ExceptionHandler
      include ActAsApiRequest
      # include Localizable
      # include DeviseTokenAuth::Concerns::SetUserByToken
      respond_to :json
      # before_action :authenticate_user!, only: :destroy

      def create
        begin
          unless new_user_params.present?
            return display_error('All params are not present')
          end
          if new_user_params.present?
            @user = User.find_by(email: params[:email].downcase)
            if @user == nil
              render json: {api_status: false, error: 'Sorry email is incorrect'}
            else
              valid_password = @user.valid_password?(new_user_params[:password])
              if valid_password
                render json: {api_status: true, user: @user}
              else
                render json: {api_status: false, error: 'Sorry password is incorrect'}
              end
            end

          else
            render json: {api_status: false, error: @user.errors}
          end
        rescue => e
          render json: {api_status: false, error: @user.errors}
        end
      end


      # def create
      #   # Check
      #   field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
      #
      #   @resource = nil
      #   if field
      #     q_value = get_case_insensitive_field_from_resource_params(field)
      #
      #     @resource = find_resource(field, q_value)
      #   end
      #
      #   if @resource && valid_params?(field, q_value) && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      #     valid_password = @resource.valid_password?(resource_params[:password])
      #     if (@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }) || !valid_password
      #       return render_create_error_bad_credentials
      #     end
      #     @token = @resource.create_token
      #     @resource.save
      #
      #     sign_in(:user, @resource, store: false, bypass: false)
      #
      #     yield @resource if block_given?
      #     render_create_success(@resource)
      #
      #   elsif @resource && !(!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      #     if @resource.respond_to?(:locked_at) && @resource.locked_at
      #       render_create_error_account_locked
      #     else
      #       render_create_error_not_confirmed
      #     end
      #   else
      #     render_create_error_bad_credentials
      #   end
      # end

      # def create
      #   user = User.find_by_email(sign_in_params[:email])
      #
      #   if user && user.valid_password?(sign_in_params[:password])
      #     @current_user = user
      #   else
      #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      #   end
      # end

      def destroy
        # remove auth instance variables so that after_action does not run
        user = remove_instance_variable(:@resource) if @resource
        client = @token.client
        @token.clear!

        if user && client && user.tokens[client]
          user.tokens.delete(client)
          user.save!

          if DeviseTokenAuth.cookie_enabled
            # If a cookie is set with a domain specified then it must be deleted with that domain specified
            # See https://api.rubyonrails.org/classes/ActionDispatch/Cookies.html
            cookies.delete(DeviseTokenAuth.cookie_name, domain: DeviseTokenAuth.cookie_attributes[:domain])
          end

          yield user if block_given?

          render_create_success_msg
        else
          render_destroy_error_msg
        end
      end

      def render_destroy_error_msg
        render json: {api_status: false, erorr: "failed" }, status: 422
      end

      def render_create_success_msg
        render json: {api_status: true, success: true }, status: 200
      end

      private

      def new_user_params
        params.permit(:email, :password)
      end

      def resource_params
        if params[:email].present?
          user =  User.find_by_email(params[:email])
          if user.present?
            params[:email]  = user.email
          end
        end
        params.permit(:email, :password, :username)
      end

      def render_create_success(user)
        render json: {api_status: true, success: true, user: user  }, status: 200
      end

      def render_destroy_success
        head(:no_content)
      end

      def render_create_error_bad_credentials
        render_errors(I18n.t('errors.authentication.invalid_credentials'), :forbidden)
      end
    end
  end
end
