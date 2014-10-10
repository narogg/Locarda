class PlacesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    #@places = Place.all
	@places = Place.where(admin_id: current_admin.id)
	
	# Get carts which have places belonging to current_admin.id
	@carts = Cart.where(place_id: Place.where(admin_id: current_admin.id)).order("updated_at DESC")
	
	
  end


  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def refresh
   @carts = Cart.where(place_id: Place.where(admin_id: current_admin.id)).order("updated_at DESC")
   #@carts = Cart.where(:conditions =>["updated_at >= ? AND updated_at <= ?", Time.now-20.seconds, Time.now])
   # User.where("id > ?", 200) 
   # Temp. hack!
   #@carts1 = Cart.where(place_id: Place.where(admin_id: current_admin.id) )
   #@carts  = @carts1.where("updated_at > ?",Time.now-3.seconds).order("updated_at DESC")
   
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :full_name, :description, :rewards, :image_url, :admin_id)
    end
end
