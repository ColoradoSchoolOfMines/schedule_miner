class DeleteTeachersSectionsMigrationAndCreateSectionsTeachersMigration < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
    drop_table :teachers_sections

    create_table :sections_teachers do |t|
      t.belongs_to :teacher
      t.belongs_to :section
    end
  end
end
