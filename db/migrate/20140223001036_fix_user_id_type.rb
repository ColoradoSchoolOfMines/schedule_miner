class FixUserIdType < ActiveRecord::Migration
  def change
    change_column :schedules, :user_id, :integer
  end
end
