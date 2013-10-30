# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Teacher.create(name: 'Yong Bakos')
Teacher.create(name: 'Keith Hellman')
Teacher.create(name: 'Cyndi Rader')
Teacher.create(name: 'William Bahn')
Teacher.create(name: 'Tracy Camp')

Course.create(name: 'Advanced Software Engineering',
              department_code: 'CSCI',
              course_number: 307)
Course.create(name: 'Linear Algebra', 
              department_code: 'MATH', 
              course_number: '332')
Course.create(name: 'Introduction to Biology',
              department_code: 'BELS',
              course_number: '101')
Course.create(name: 'Introduction to Mechanics',
              department_code: 'PHGN',
              course_number: '100')
Course.create(name: 'Introduction to Electromagnetics',
              department_code: 'PHGN',
              course_number: '200')
Course.create(name: 'Chemistry I',
              department_code: 'CHGN',
              course_number: '100')

Section.create(start_time: '8:00AM',
               end_time: '8:50AM',
               days_of_week: 'MWF',
               building_code: 'MZ',
               room_number: '336',
               crn: 80432,
               available_slots: 40,
               code: 'MATH332')
Section.create(start_time: '10:00AM',
               end_time: '11:30AM',
               days_of_week: 'TTh',
               building_code: 'BB',
               room_number: '280',
               crn: 80444,
               available_slots: 40,
               code: 'MATH223')
Section.create(start_time: '1:00PM',
               end_time: '1:50PM',
               days_of_week: 'MWF',
               building_code: 'CH',
               room_number: '102',
               crn: 40045,
               available_slots: 30,
               code: 'CSCI234')
