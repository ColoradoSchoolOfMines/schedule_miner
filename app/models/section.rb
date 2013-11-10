class Section < ActiveRecord::Base
  belongs_to :course
  belongs_to :building, foreign_key: 'building_code', primary_key: 'code'
  has_and_belongs_to_many :teachers
end
