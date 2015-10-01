class RegistrationsController < Devise::RegistrationsController

    # before_action :sign_up_params || :account_update_params, if: :devise_controller?

    private

    def sign_up_params
        params.require( :user ).permit( :first_name, :last_name, :profile_name, :email, :password, :password_confirmation )
    end

    def account_update_params
        params.require( :user ).permit( :first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :current_password)
    end

end
        # devise_parameter_sanitizer.for(:sign_up) do | u |
        #     u.permit( :first_name, :last_name, :profile_name, :email, :password, :password_confirmation)
        # end
        # devise_parameter_sanitizer.for(:sign_in) do | u |
        #     u.permit( :profile_name, :password, :remember_me)
        # end