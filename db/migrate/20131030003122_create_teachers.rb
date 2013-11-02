class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      # t.string :first_name
      # t.string :last_name
      # t.string :department
      # t.string :department_code
      # t.integer :phone_number
      # t.string :email
      # t.string :office

      t.timestamps
    end
  end
end
