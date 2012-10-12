class Admin::AdminController < ApplicationController
  layout 'productadmin'
  
  def create
    if User.authenticate?(params[:username], params[:password])
      session[:user_id] = params[:username]
      redirect_to admin_product_path, :notice => t('login.login_success')
      
    else
      flash.now[:alert] = t('login.error')
      render 'new'
    end
  end
  
  def destroy
    reset_session
    redirect_to admin_login_path, :notice => t('login.logout_success')
  end
  
  protected
  
  def current_user
    return unless session[:user_id]
    @current_user ||= session[:user_id]
  end
  
  def authenticate
    logged_in? ? true : access_denied
  end
  
  def logged_in?
    current_user.present?
  end
  
  def access_denied
    redirect_to admin_login_path, :notice => t('login.access_denied') and return false
  end
  
  helper_method :current_user
  helper_method :logged_in
  
end
