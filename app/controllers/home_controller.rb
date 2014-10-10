class HomeController < ApplicationController
  def index
  @places = Place.all
  #render :json => @places
  end
  
  def api
  @places = Place.all
  render :json => @places
  end
end
