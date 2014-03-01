class UsersController < ApplicationController
  def index
  	@schedules = Schedules.all

  	respond_to do |format|
  		format.html
  		format.json { render json: @schedules }
  	end
  end
end
