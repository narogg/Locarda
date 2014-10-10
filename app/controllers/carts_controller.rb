class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!
  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
	#logger.error("tudi tukaj")
	#@places = Place.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create    
  
    # @cart = Cart.new(cart_params)
	# Me, creating a card with a user&place, not yet saving
	@user = current_user
	place = Place.find(params[:place_id])
	@cart = @user.carts.build(:place => place)
	@cart.increment(:checked_num, by = 1)

		
	# if new card save, 
	# else update cart.checked_num +1 for current user&place	
	
	#Finds the first record with the given attributes, or creates a record with the attributes if one is not found:
    ## Find the first user named "Penélope" or create a new one.
    #User.find_or_create_by(first_name: 'Penélope')
    ## => #<User id: 1, first_name: "Penélope", last_name: nil>
    # Cart.find_or_create_by(user_id: @user.id, place_id: place.id) => was working also
	check_in = Cart.find_or_initialize_by(user_id: @user.id, place_id: place.id)	
	check_in.increment(:checked_num, by = 1)	
	
	if check_in.new_record?		  
	  check_in.save!	  
	else	
	 check_in.update!(checked_num: check_in.checked_num)
	end
	 
	

	respond_to do |format|
	format.html { redirect_to home_path, notice: "#{@user.email} uspjesno ste se prijavili u #{place.name}" }
    format.json { render action: 'show', status: :created, location: @cart }
    end
	
	# Original create code:	
	#respond_to do |format|
    #  if @cart.save
    #    #format.html { redirect_to carts_path, notice: 'You have successfully checked in.' }
	#	format.html { redirect_to places_path, notice: "#{@user.email} uspjesno ste se prijavili u #{place.name}" }
    #    format.json { render action: 'show', status: :created, location: @cart }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @cart.errors, status: :unprocessable_entity }
    #  end
    #end
  
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  
  def subtract
  @cart = Cart.find params[:id]
  
  logger.error("v sabtraktu sam")
  respond_to do |format|
	  
	  @cart.increment(:points, by = -1)
	  #@cart.update!(points: @cart.points)

	  # update_columns will omit updating the timestamp fields
	  @cart.update_columns(points: @cart.points)

	  
	  #logger.error("bodovi #{@cart.user.email}")
	  # def update
	  # Rails 3
      # @book = Book.find(params[:id]) 
      # if @book.update_attributes(params[:book])
	  # @house.update_attributes(:colour => newcolour)
	  # @book.update_attributes(params[:book][:title])
	  # @book.update_attributes(params[:book][:price])
	  
	  # Rails 4 @article.update_columns(article_params)
	  
	  #@cart.increment(:checked_num, by = 1)
	  
        format.html { redirect_to places_path, notice: "Bodovi smanjeni za korisnika #{@cart.user.email}" }
        format.json { head :no_content }
      
    end
  end
  
  def update
  # Here we have a cart id from the frontend
  @cart = Cart.find params[:id]
  logger.error("v updateu sam")
   
  #nekaj = @cart.give
  #if nekaj.to_s  == "add"
  #logger.error("tudi tukaj ne to_s #{nekaj} ")
  #end
  #logger.error("gotohell #{nekaj.to_s} ")

  respond_to do |format|
	  if @cart.update_attributes params[@cart.id]
	  @cart.increment(:points, by = 1)
	  
	  #@cart.update!(points: @cart.points)
	  # update_columns will omit updating the timestamp fields
	  @cart.update_columns(points: @cart.points)

	  # def update
	  # Rails 3
      # @book = Book.find(params[:id]) 
      # if @book.update_attributes(params[:book])
	  # @house.update_attributes(:colour => newcolour)
	  # @book.update_attributes(params[:book][:title])
	  # @book.update_attributes(params[:book][:price])
	  
	  # Rails 4 @article.update_columns(article_params)
	  
	  #@cart.increment(:checked_num, by = 1)
	  
        format.html { redirect_to places_path, notice: "Bodovi dodani za korisnika #{@cart.user.email}" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
  
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user_id, :place_id, :points, :checked_num)
    end
end
