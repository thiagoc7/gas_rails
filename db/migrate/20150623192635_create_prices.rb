class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :gasoline
      t.string :amount
      t.references :supplier, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
