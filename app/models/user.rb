class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice("uid")).first || create_from_omniauth(auth)
  end
  def self.create_from_omniauth(auth)
    create! do |user|
      # user.provider = auth['provider']
      user.uid = auth['id']
      user.first_name = auth['info']['first_name'] #Includes middle name, add gsub(/\s.+/, '') for just firstname
      user.last_name = auth['info']['last_name']
      user.email = auth['info']['email']
    end
  end
  
  has_many :schedules
end
