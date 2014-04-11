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
	  	user=@current_user
	end
	  
	def update
	  	user=@current_user
	  	
	  	respond_to do |format|
	  		if user.update_attributes(params[:user])
	  			format.html { redirect_to users_url, notice: "User was successfully updated" }
	  			format.json { head :no_content }
	  		else
	  			format.html { render action: "edit" }
	  			format.json { render json: user.errors, status: :unprocessable_entity }
	  		end
	  	end
	end
end
