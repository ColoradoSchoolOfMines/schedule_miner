class AddUserIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :user_id, :number

  end
end
