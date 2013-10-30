class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
