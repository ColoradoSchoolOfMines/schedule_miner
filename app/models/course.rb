class Course < ActiveRecord::Base
  validates :name, :department_code, :course_number, presence: true
  validates :name, uniqueness: true
end
