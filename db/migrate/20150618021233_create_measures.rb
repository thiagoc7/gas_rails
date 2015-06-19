class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.references :plan, index: true, foreign_key: true
      t.references :tank, index: true, foreign_key: true
      t.integer :buy_volume, default: 0
      t.integer :forecast_volume, default: 0
      t.integer :final_volume
      t.string :comments

      t.timestamps null: false
    end
  end
end
