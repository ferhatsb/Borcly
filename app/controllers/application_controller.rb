class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_if_first_login

  def check_if_first_login
    if current_user && current_user.first_time && not_matches
      redirect_to admin_accounts_url and return
    end
  end


  def after_sign_in_path_for(resource)
     admin_root_path
  end

  def not_matches
    return false if request.path == admin_accounts_path
    return false if request.path == admin_update_account_path
    return false if request.path == user_omniauth_callback_path(:twitter)
    return false if request.path == user_omniauth_callback_path(:facebook)
    true
  end

end
