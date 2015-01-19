class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update]
  respond_to :html

  def register
  
    # A user will have one registration record for the mobile device. 
	# If it's a new user/device, regID is saved into Registration model 
	# else it is updated (google GCM changes regIDs)
  	logger.error('tudi tukaj u POST /register.json sam')
	regID  = params[:regID]
	userID = params[:userID]	
	#logger.error(regID)
	#logger.error(userID)
	registration = Registration.find_or_initialize_by(user_id: userID)	
	
	logger.error(registration)
	
	if registration.new_record?		  
	  registration.save!	  
	  logger.error('Saveam')
	else	
	 registration.update(gcm_reg_id: regID)
	 #registration.touch
	 logger.error('updateam')
	end
  
   	respond_to do |format|
	  format.json  { render :json =>{ :message => regID} }
	end   
  
    #check_in = Cart.find_or_initialize_by(user_id: @user.id, place_id: place.id)	
	#check_in.increment(:checked_num, by = 1)	
	#
	#if check_in.new_record?		  
	#  check_in.save!	  
	#else	
	# check_in.update!(checked_num: check_in.checked_num)
	#end
	
  end
  
  def index
    @registrations = Registration.all
    respond_with(@registrations)
  end

  def show
    respond_with(@registration)
  end

  def new
    @registration = Registration.new
    respond_with(@registration)
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    flash[:notice] = 'Registration was successfully created.' if @registration.save
    respond_with(@registration)
  end

  def update
    flash[:notice] = 'Registration was successfully updated.' if @registration.update(registration_params)
    respond_with(@registration)
  end

  def destroy
    @registration.destroy
    respond_with(@registration)
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:user_id, :gcm_reg_id)
    end
end
