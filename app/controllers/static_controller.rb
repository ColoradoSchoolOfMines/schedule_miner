class StaticController < ApplicationController

  def index
  end

  def update
    sm = StaticHelper::SMParser.new
    sm.noko_parse
    sm.create_class_nodes
    sm.build_classes

    Teacher.delete_all
    Course.delete_all
    Section.delete_all

    @unknown_buildings = {}
    @unknown_departments = {}

    ActiveRecord::Base.transaction do 
      sm.classes.each do |class_name,sections|
        if !Department.find_by_code(sections[0]['Department Code'])
          @unknown_departments[sections[0]['Department Code']] = true
          next
        end

        course = Course.create(
          name: class_name,
          department_code: sections[0]['Department Code'],
          course_number: sections[0]['Course Number'],
        )
        sections.each do |section_info|
          teachers = section_info['Instructors'].map do |teacher_name|
            teacher_name.sub!(/ \(P\)/, '')
            Teacher.find_or_create_by_name(teacher_name)
          end

          building = Building.find_by_name(section_info['Building'])

          if !building
            @unknown_buildings[section_info['Building']] = true
            next
          end

          Section.create(
            course: course,
            teachers: teachers,
            start_time: section_info['Start Time'],
            end_time: section_info['End Time'],
            days_of_week: section_info['Days'],
            building_code: building.code,
            room_number: section_info['Room'],
            crn: section_info['CRN'],
          )
        end
      end
    end

    respond_to do |format|
      format.html #{ redirect_to static_url, notice: 'Classes generated'}
    end
  end
end
