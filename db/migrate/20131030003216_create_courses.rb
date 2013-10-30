class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :department_code
      t.string :course_number

      t.timestamps
    end
  end
end
