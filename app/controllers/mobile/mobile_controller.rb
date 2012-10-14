class Mobile::MobileController < ApplicationController
  before_filter :set_theme
  
  def set_theme
    cookies[:theme] = params[:theme] unless params[:theme].blank?
  end
  
  def theme
    cookies[:theme].blank? ? 'c' : cookies[:theme]
  end
  
  helper_method :theme
end
