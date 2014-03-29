class AddAdminToUsers < ActiveRecord::Migration
  def change
  		add_column :users, :admin_flag, :number
  end
end
