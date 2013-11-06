class Course < ActiveRecord::Base
  validates :name, :department_code, :course_number, presence: true
  validates :name, uniqueness: true

  has_many :sections, dependent: :destroy
  # has_many :teachers
  # has_many :buildings
end
