class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.int :course_id
      t.int :teacher_id
      t.time :start_time
      t.time :end_time
      t.string :days_of_week
      t.string :building_code
      t.string :room_number
      t.int :crn
      t.int :available_slots
      t.string :code

      t.timestamps
    end
  end
end
