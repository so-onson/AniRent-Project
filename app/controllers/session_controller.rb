class SessionController < ApplicationController
  def login;  end

  def signup
    @user = User.find_by(email: params[:email])
    return redirect_to_login if @user.nil?
    return redirect_to_login unless @user.authenticate(params[:password])

    session[:current_user_id] = @user.id
    redirect_to home_profile_path, notice: "#{t('flash.enter')}"
  end

  def logout
    # session[:current_user_id] = nil
    session.delete(:current_user_id)
    redirect_to root_path, notice: "#{t('flash.exit')}"
    
  end

  private

  def redirect_to_login
    redirect_to session_login_path, flash: { alert: "#{t('flash.pas_error')}"}
  end

end