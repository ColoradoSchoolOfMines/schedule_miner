class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :course_id
      t.integer :teacher_id
      t.time :start_time
      t.time :end_time
      t.string :days_of_week
      t.string :building_code
      t.string :room_number
      t.integer :crn
      t.integer :available_slots
      t.string :code

      t.timestamps
    end
  end
end
