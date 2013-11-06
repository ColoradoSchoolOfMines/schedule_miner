class MapTeachersToSections < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
    create_table :teachers_sections do |t|
      t.belongs_to :teacher
      t.belongs_to :section
    end 
  end
end
