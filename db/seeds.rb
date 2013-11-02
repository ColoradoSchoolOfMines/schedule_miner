# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Teacher.delete_all
Course.delete_all
Section.delete_all
Building.delete_all
Department.delete_all

Teacher.create(name: 'Yong J. Bakos')
Teacher.create(name: 'Keith E. Hellman')
Teacher.create(name: 'Cynthia A. Rader')
Teacher.create(name: 'William Louis Bahn')
Teacher.create(name: 'Tracy Camp')
Teacher.create(name: 'Steven Pankavich')
Teacher.create(name: 'Larry Edward Johnson')
Teacher.create(name: 'Randall Wayne Bower')
Teacher.create(name: 'James Kaleb Slyby')
Teacher.create(name: 'Oscar Thyago Jose Duarte Dantas Lisboa Mota')
Teacher.create(name: 'Ira David Hale')
Teacher.create(name: 'Christopher Robert Painter-Wakefield')
Teacher.create(name: 'Randy L. Haupt')
Teacher.create(name: 'Qi Han')
Teacher.create(name: 'William A. Hoff')
Teacher.create(name: 'Josh Ryan Thomas')
Teacher.create(name: 'Andrzej Szymczak')
Teacher.create(name: 'Dejun Yang')
Teacher.create(name: 'Hua Wang')
Teacher.create(name: 'Mahadevan Ganesh')
Teacher.create(name: 'Dinesh Prakash Mehta')

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

Department.create(code: 'CSCI', name: 'Computer Science')
Department.create(code: 'MATH', name: 'Mathematics')
Department.create(code: 'PHGN', name: 'Physics')
Building.create(code: 'MZ', name: 'Marquez Building')
Building.create(code: 'BB', name: 'Brown Building')
Building.create(code: 'CH', name: 'Chauvenet Building')