class Place < ActiveRecord::Base
has_many :users, :through => :carts
has_many :carts, dependent: :destroy


  #def add_visit(cart_id)
  #current_visit = carts.where(:place_id => place_id).first
  #  if current_visit
  #    current_visit.quantity += 1
  #  else
  #    current_visit = Cart.new(:place_id=>place_id)
  #    carts << current_visit
  #  end
  #current_visit
  #end
  
end
