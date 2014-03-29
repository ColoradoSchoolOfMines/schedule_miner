class UsersController < ApplicationController
	before_filter :authenticate_user!

	def index
	  	@user=@current_user
		respond_to do |format|
	  		format.html
	  		format.json { render json: @schedules }
	  	end
	end

	def edit
	  	@user=@current_user
	end
	  
	def update
	  	@user=@current_user
	  	
	  	respond_to do |format|
	  		format.html { redirect_to users_url, notice: "User was successfully updated" }
	  		format.json { head :no_content }
	  	end
	end
end
