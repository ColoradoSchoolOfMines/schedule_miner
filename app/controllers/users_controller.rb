class UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
  	@schedules = Schedule.find_all_by_user_id(params[:current_user_id])
  	respond_to do |format|
  		format.html
  		format.json { render json: @schedules }
  	end
  end
end
