class Building < ActiveRecord::Base
  has_many :sections, foreign_key: 'building_code', primary_key: 'code'
end
