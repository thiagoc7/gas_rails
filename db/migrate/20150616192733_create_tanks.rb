class CreateTanks < ActiveRecord::Migration
  def change
    create_table :tanks do |t|
      t.string :gasoline
      t.integer :capacity
      t.integer :min_volume
      t.integer :max_volume
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
