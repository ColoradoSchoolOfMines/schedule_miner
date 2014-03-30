class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@schedules = Schedule.find_all_by_user_id(@current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    @schedule.user_id = @current_user.id

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
    @schedule = Schedule.find(params[:id])


    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
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

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def add
    schedule = Schedule.find(params[:schedule_id])
    section = Section.find(params[:section_id])

    respond_to do |format|
      if (schedule.sections << section)
        format.html { redirect_to schedule, notice: 'Successfully added section to schedule.' }
        format.json { render json: schedule, status: :created, location: schedule }
      else
        format.html { redirect_to schedule, notice: 'Section already exists in that schedule.' }
        format.json { render json: schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    schedule = Schedule.find(params[:schedule_id])
    section = Section.find(params[:section_id])

    respond_to do |format|
      if (schedule.sections.delete(section))
        format.html { redirect_to schedule, notice: 'Successfully removed section from the schedule.' }
        format.json { render json: schedule, status: :created, location: schedule }
      else
        format.html { redirect_to schedule, notice: 'Section doesnt exist in this schedule.' }
        format.json { render json: schedule.errors, status: :unprocessable_entity }
      end
    end 
  end

  def duplicate
    old.schedule = Schedule.find(params[:schedule_id])

    respond_to do |format|
        if (neW.schedule = Schedule.new(old.schedule.attributes))
        format.html { redirect_to schedule, notice: 'Successfully dupliacted schedule.' }
        format.json { render json: schedule, status: :created, location: schedule }
      else
        format.html { redirect_to schedule, notice: 'Can not duplicate schedule.' }
        format.json { render json: schedule.errors, status: :unprocessable_entity }
      end
    end
  end

end
