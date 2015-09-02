class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :agencia
      t.string :conta_corrente
      t.string :variacao
      t.string :aceite, default: "N"
      t.string :carteira
      t.string :convenio

      t.boolean :default_bank, default: false

      t.timestamps null: false
    end
  end
end
