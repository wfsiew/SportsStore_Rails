class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  protected
  
  def set_locale
    cookies[:locale] = params[:locale] unless params[:locale].blank?
    I18n.locale = cookies[:locale]
  end
  
  def request_path
    request.env['REQUEST_PATH']
  end
  
  helper_method :request_path
end
