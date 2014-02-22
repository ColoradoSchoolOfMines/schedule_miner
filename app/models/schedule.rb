class Schedule < ActiveRecord::Base
	has_many: :sections
	belongs_to: :user
end
