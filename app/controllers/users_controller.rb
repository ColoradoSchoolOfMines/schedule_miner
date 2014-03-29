class UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
  
  	respond_to do |format|
  		format.html
  		format.json { render json: @schedules }
  	end
  end

  def edit
   
   	respond_to do |format|
  		format.html
  		format.json { render json: @schedules }
  	end
  end

end
