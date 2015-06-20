class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :date, null: false
      t.integer :day_of_week
      t.integer :date_type

      t.boolean :finished, default: false

      t.string :holiday
      t.integer :holiday_reference

      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
