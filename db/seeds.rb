# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
if Teacher.count == 0 then
  yong = Teacher.create(name: 'Yong Bakos')
  keith = Teacher.create(name: 'Keith Hellman')
  cyndi = Teacher.create(name: 'Cyndi Rader')
  william = Teacher.create(name: 'William Bahn')
  tracy = Teacher.create(name: 'Tracy Camp')
  steven = Teacher.create(name: 'Steven Pankavich')
end

if Course.count == 0 then
  ase = Course.create(name: 'Advanced Software Engineering',
                department_code: 'CSCI',
                course_number: 307)
  linalg = Course.create(name: 'Linear Algebra', 
                department_code: 'MATH', 
                course_number: '332')
  bio = Course.create(name: 'Introduction to Biology',
                department_code: 'BIOL',
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
end

Department.find_or_create_by_code(code: 'AFGN', name: 'Air Force')
Department.find_or_create_by_code(code: 'BIOL', name: 'Biology')
Department.find_or_create_by_code(code: 'CBEN', name: 'Chemical and Biological Engineering')
Department.find_or_create_by_code(code: 'CEEN', name: 'Civil Engineering')
Department.find_or_create_by_code(code: 'CHGC', name: 'Geochemistry')
Department.find_or_create_by_code(code: 'CHGN', name: 'General Chemistry')
Department.find_or_create_by_code(code: 'COOP', name: 'Cooperative Education')
Department.find_or_create_by_code(code: 'CSCI', name: 'Computer Science')
Department.find_or_create_by_code(code: 'CSM', name: 'General')
Department.find_or_create_by_code(code: 'EBGN', name: 'Economics and Business')
Department.find_or_create_by_code(code: 'EENG', name: 'Electrical Engineering')
Department.find_or_create_by_code(code: 'EGGN', name: 'Engineering')
Department.find_or_create_by_code(code: 'ENGY', name: 'Energy')
Department.find_or_create_by_code(code: 'EPIC', name: 'EPICS')
Department.find_or_create_by_code(code: 'GEGN', name: 'Geological Engineering')
Department.find_or_create_by_code(code: 'GEOL', name: 'Geology')
Department.find_or_create_by_code(code: 'GEGX', name: 'Geochemical Exploration')
Department.find_or_create_by_code(code: 'GPGN', name: 'Geophysical Engineering')
Department.find_or_create_by_code(code: 'HNRS', name: 'Honors Program')
Department.find_or_create_by_code(code: 'LAIS', name: 'Liberal Arts and International Studies')
Department.find_or_create_by_code(code: 'LICM', name: 'Communications')
Department.find_or_create_by_code(code: 'LIFL', name: 'Foreign Language')
Department.find_or_create_by_code(code: 'LIMU', name: 'Music')
Department.find_or_create_by_code(code: 'MATH', name: 'Mathematics')
Department.find_or_create_by_code(code: 'MEGN', name: 'Mechanical Engineering')
Department.find_or_create_by_code(code: 'MLGN', name: 'Materials Science')
Department.find_or_create_by_code(code: 'MNGN', name: 'Mining Engineering')
Department.find_or_create_by_code(code: 'MSGN', name: 'Military Science')
Department.find_or_create_by_code(code: 'MTGN', name: 'Metals and Materials Engineering')
Department.find_or_create_by_code(code: 'NUGN', name: 'Nuclear Engineering')
Department.find_or_create_by_code(code: 'PAGN', name: 'Physical Activities')
Department.find_or_create_by_code(code: 'PEGN', name: 'Petroleum Engineering')
Department.find_or_create_by_code(code: 'PHGN', name: 'Engineering Physics')
Department.find_or_create_by_code(code: 'SYGN', name: 'Systems Courses')

Building.find_or_create_by_code(code: 'AH', name: 'Alderson Hall')
Building.find_or_create_by_code(code: 'BB', name: 'Brown Building')
Building.find_or_create_by_code(code: 'BE', name: 'Berthoud Hall')
Building.find_or_create_by_code(code: 'CH', name: 'Chauvenet Hall')
Building.find_or_create_by_code(code: 'CO', name: 'Coolbaugh Hall')
Building.find_or_create_by_code(code: 'CT', name: 'CTLM')
Building.find_or_create_by_code(code: 'EH', name: 'Engineering Hall')
Building.find_or_create_by_code(code: 'EM', name: 'Edgar Mine')
Building.find_or_create_by_code(code: 'FD', name: 'Ford Dealership')
Building.find_or_create_by_code(code: 'FH', name: 'Field House')
Building.find_or_create_by_code(code: 'GC', name: 'Green Center')
Building.find_or_create_by_code(code: 'GY', name: 'Volk Gymnasium')
Building.find_or_create_by_code(code: 'HH', name: 'Hill Hall')
Building.find_or_create_by_code(code: 'MH', name: 'Meyer Hall')
Building.find_or_create_by_code(code: 'MZ', name: 'Marquez Hall')
Building.find_or_create_by_code(code: 'NR', name: 'No Room')
Building.find_or_create_by_code(code: 'OFF', name: 'Off Campus')
Building.find_or_create_by_code(code: 'RC', name: 'Recreation Center')
Building.find_or_create_by_code(code: 'SC', name: 'Student Center')
Building.find_or_create_by_code(code: 'SH', name: 'Stratton Hall')
Building.find_or_create_by_code(code: 'TBA', name: 'TBA')

