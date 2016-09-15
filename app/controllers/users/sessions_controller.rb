class Users::SessionsController < Devise::SessionsController
  before_action :redirect_admin_user, only: [:new]
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
   def destroy
     super
   end

   protected

    def redirect_admin_user
      if admin_signed_in?
        redirect_to root_url, alert: "Please sign out of admin session"
      end
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
