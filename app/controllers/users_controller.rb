class UsersController < ApplicationController
	before_filter :authenticate_user!

	def index
	  
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
	  		format.html # index.html.erb
	  		format.json { render json: @user }
	  	end
	end
	  
	def show
	  	@user=@current_user
	end
end
