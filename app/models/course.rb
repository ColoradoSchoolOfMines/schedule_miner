class Course < ActiveRecord::Base
  validates :name, :department_code, :course_number, presence: true
  validates_uniqueness_of :department_code, :scope => [ :course_number ]

  has_many :sections, dependent: :destroy
  # has_many :teachers
  # has_many :buildings
end
