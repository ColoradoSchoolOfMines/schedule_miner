class MapSchedulesToSections < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
    create_table :schedules_sections do |t|
      t.belongs_to :schedule
      t.belongs_to :section
    end 
  end
end
