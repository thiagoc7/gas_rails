class CreateTanks < ActiveRecord::Migration
  def change
    create_table :tanks do |t|
      t.string :gasoline
      t.decimal :capacity
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
