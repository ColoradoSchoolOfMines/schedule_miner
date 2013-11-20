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

# Teacher.create(name: 'Yong J. Bakos')
# Teacher.create(name: 'Keith E. Hellman')
# Teacher.create(name: 'Cynthia A. Rader')
# Teacher.create(name: 'William Louis Bahn')
# Teacher.create(name: 'Tracy Camp')
# Teacher.create(name: 'Steven Pankavich')
# Teacher.create(name: 'Larry Edward Johnson')
# Teacher.create(name: 'Randall Wayne Bower')
# Teacher.create(name: 'James Kaleb Slyby')
# Teacher.create(name: 'Oscar Thyago Jose Duarte Dantas Lisboa Mota')
# Teacher.create(name: 'Ira David Hale')
# Teacher.create(name: 'Christopher Robert Painter-Wakefield')
# Teacher.create(name: 'Randy L. Haupt')
# Teacher.create(name: 'Qi Han')
# Teacher.create(name: 'William A. Hoff')
# Teacher.create(name: 'Josh Ryan Thomas')
# Teacher.create(name: 'Andrzej Szymczak')
# Teacher.create(name: 'Dejun Yang')
# Teacher.create(name: 'Hua Wang')
# Teacher.create(name: 'Mahadevan Ganesh')
# Teacher.create(name: 'Dinesh Prakash Mehta')
yong = Teacher.create(name: 'Yong Bakos')
keith = Teacher.create(name: 'Keith Hellman')
cyndi = Teacher.create(name: 'Cyndi Rader')
william = Teacher.create(name: 'William Bahn')
tracy = Teacher.create(name: 'Tracy Camp')
steven = Teacher.create(name: 'Steven Pankavich')

ase = Course.create(name: 'Advanced Software Engineering',
              department_code: 'CSCI',
              course_number: 307)
linalg = Course.create(name: 'Linear Algebra', 
              department_code: 'MATH', 
              course_number: '332')
bio = Course.create(name: 'Introduction to Biology',
              department_code: 'BELS',
              course_number: '101')
mechanics = Course.create(name: 'Introduction to Mechanics',
              department_code: 'PHGN',
              course_number: '100')
electro = Course.create(name: 'Introduction to Electromagnetics',
              department_code: 'PHGN',
              course_number: '200')
chemI = Course.create(name: 'Chemistry I',
              department_code: 'CHGN',
              course_number: '100')


Section.create(start_time: '8:00AM',
               end_time: '8:50AM',
               days_of_week: 'MWF',
               building_code: 'MZ',
               room_number: '336',
               crn: 80432,
               available_slots: 40,
               code: 'MATH332',
               # teacher_id: Teacher.find_by_name("Yong Bakos").id)
               teachers: [yong],
               course: ase)
Section.create(start_time: '10:00AM',
               end_time: '11:30AM',
               days_of_week: 'TR',
               building_code: 'BB',
               room_number: '280',
               crn: 80444,
               available_slots: 40,
               code: 'MATH223',
               # teacher_id: Teacher.find_by_name('Keith Hellman').id)
               teachers: [keith],
               course: electro)
Section.create(start_time: '1:00PM',
               end_time: '1:50PM',
               days_of_week: 'MWF',
               building_code: 'CH',
               room_number: '102',
               crn: 40045,
               available_slots: 30,
               code: 'CSCI234',
               # teacher_id: Teacher.find_by_name('Steven Pankavich').id)
               teachers: [tracy,william],
               course: chemI)

Department.create(code: 'AFGN', name: 'Air Force')
Department.create(code: 'BIOL', name: 'Biology')
Department.create(code: 'CBEN', name: 'Chemical and Biological Engineering')
Department.create(code: 'CEEN', name: 'Civil Engineering')
Department.create(code: 'CHGC', name: 'Geochemistry')
Department.create(code: 'CHGN', name: 'General Chemistry')
Department.create(code: 'COOP', name: 'Cooperative Education')
Department.create(code: 'CSCI', name: 'Computer Science')
Department.create(code: 'CSM', name: 'General')
Department.create(code: 'EBGN', name: 'Economics and Business')
Department.create(code: 'EENG', name: 'Electrical Engineering')
Department.create(code: 'EGGN', name: 'Engineering')
Department.create(code: 'ENGY', name: 'Energy')
Department.create(code: 'EPIC', name: 'EPICS')
Department.create(code: 'GEGN', name: 'Geological Engineering')
Department.create(code: 'GEOL', name: 'Geology')
Department.create(code: 'GEGX', name: 'Geochemical Exploration')
Department.create(code: 'GPGN', name: 'Geophysical Engineering')
Department.create(code: 'HNRS', name: 'Honors Program')
Department.create(code: 'LAIS', name: 'Liberal Arts and International Studies')
Department.create(code: 'LICM', name: 'Communications')
Department.create(code: 'LIFL', name: 'Foreign Language')
Department.create(code: 'LIMU', name: 'Music')
Department.create(code: 'MATH', name: 'Mathematics')
Department.create(code: 'MEGN', name: 'Mechanical Engineering')
Department.create(code: 'MLGN', name: 'Materials Science')
Department.create(code: 'MNGN', name: 'Mining Engineering')
Department.create(code: 'MSGN', name: 'Military Science')
Department.create(code: 'MTGN', name: 'Metals and Materials Engineering')
Department.create(code: 'NUGN', name: 'Nuclear Engineering')
Department.create(code: 'PAGN', name: 'Physical Activities')
Department.create(code: 'PEGN', name: 'Petroleum Engineering')
Department.create(code: 'PHGN', name: 'Engineering Physics')
Department.create(code: 'SYGN', name: 'Systems Courses')

Building.create(code: 'AH', name: 'Alderson Hall')
Building.create(code: 'BB', name: 'Brown Building')
Building.create(code: 'BE', name: 'Berthoud Hall')
Building.create(code: 'CH', name: 'Chauvenet Hall')
Building.create(code: 'CO', name: 'Coolbaugh Hall')
Building.create(code: 'CT', name: 'CTLM')
Building.create(code: 'EH', name: 'Engineering Hall')
Building.create(code: 'EM', name: 'Edgar Mine')
Building.create(code: 'FD', name: 'Ford Dealership')
Building.create(code: 'FH', name: 'Field House')
Building.create(code: 'GC', name: 'Green Center')
Building.create(code: 'GY', name: 'Volk Gymnasium')
Building.create(code: 'HH', name: 'Hill Hall')
Building.create(code: 'MH', name: 'Meyer Hall')
Building.create(code: 'MZ', name: 'Marquez Hall')
Building.create(code: 'NR', name: 'No Room')
Building.create(code: 'OFF', name: 'Off Campus')
Building.create(code: 'RC', name: 'Recreation Center')
Building.create(code: 'SC', name: 'Student Center')
Building.create(code: 'SH', name: 'Stratton Hall')
Building.create(code: 'TBA', name: 'TBA')

