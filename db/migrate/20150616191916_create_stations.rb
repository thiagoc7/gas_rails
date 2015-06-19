class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :strong_days
      t.string :weak_days

      t.timestamps null: false
    end
  end
end
