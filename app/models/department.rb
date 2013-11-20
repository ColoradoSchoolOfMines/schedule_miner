class Department < ActiveRecord::Base
  has_many :courses, foreign_key: 'department_code', primary_key: 'code'
end
