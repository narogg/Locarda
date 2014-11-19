class HomeController < ApplicationController
  def index
  @places = Place.all
  #render :json => @places
  end
  
  def api  
  #logger.error("in home/api, userid from incoming json is: #{ params[:user_id]}")  
  user_id = params[:user_id]
    
  @places = Place.find_by_sql ["select places.*, carts.points from places LEFT JOIN carts ON places.id = carts.place_id and carts.user_id = ? order by places.id asc", user_id ]
  
  #@places = Place.all.order('id ASC')
  render :json => @places
  end
end
