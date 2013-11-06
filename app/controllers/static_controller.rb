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
    Building.delete_all
    Department.delete_all

    ActiveRecord::Base.transaction do 
      sm.classes.each do |class_name,sections|
        course = Course.create(
          name: class_name,
          department_code: sections[0]['Department Code'],
          course_number: sections[0]['Course Number'],
        )
        sections.each do |section_info|
          teachers = [*section_info['Instructors']].map do |teacher_name|
            teacher_name.sub!(/ \(P\)/, '')
            Teacher.find_or_create_by_name(teacher_name)
          end

          time_info = /(\d{1,2}:\d{2}) ([ap]m) - (\d{1,2}:\d{2}) ([ap]m)/.match(section_info['Time'])
          location_info = section_info['Where'].split(/ /)
          if location_info.size >= 2
            building_code = location_info[0..-2].join(' ')
            room = location_info[-1]
          else
            building_code = location_info[0]
            room = ''
          end
          Section.create(
            course: course,
            teachers: teachers,
            start_time: time_info ? (time_info[1] + time_info[2].upcase) : 'TBA',
            end_time: time_info ? (time_info[3] + time_info[4].upcase) : 'TBA',
            days_of_week: section_info['Days'],
            building_code: building_code,
            room_number: room,
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
