class ApplicationController < ActionController::Base
    around_action :switch_locale
    helper_method :current_user
    helper_method :check_role



    private

    def switch_locale(&action)
        locale = locale_from_url || I18n.default_locale
        I18n.with_locale locale, &action
    end

    def locale_from_url
        locale = params[:locale]

        return locale if I18n.available_locales.map(&:to_s).include?(locale)
    end

    def default_url_options
        { locale: I18n.locale }
    end


    def current_user
        @current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
    end

    def current_cus
        @current_cus ||= Customer.find_by(user_id: session[:current_user_id]) if session[:current_user_id]
    end

    def check_role
        if current_user.nil?
            redirect_to  root_path, alert: "#{t('flash.login_error')}"
        end
    end

    def check_owner
    end
end
