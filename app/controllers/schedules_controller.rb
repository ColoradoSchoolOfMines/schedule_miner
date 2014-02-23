class SchedulesController < ApplicationController
  def index
  	@schedules = Schedule.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def new
		#@schedule = Schedule.new
  end
end
