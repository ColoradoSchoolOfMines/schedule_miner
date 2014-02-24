class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@schedules = Schedule.find_all_by_user_id(current_user.id) || []
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end
end
