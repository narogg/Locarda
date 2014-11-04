class HomeController < ApplicationController
  def index
  @places = Place.all
  #render :json => @places
  end
  
  def api
  @places = Place.all.order('id ASC')
  render :json => @places
  end
end
