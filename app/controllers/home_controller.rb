class HomeController < ApplicationController
  layout false
  
  def index
    respond_to do |fmt|
      fmt.html
    end
  end
  
end