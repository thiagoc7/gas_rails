class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :date, null: false
      t.string :holiday
      t.boolean :day_before, default: false
      t.string :day_of_week
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
