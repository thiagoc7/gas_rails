class AddNumberToTanks < ActiveRecord::Migration
  def change
    add_column :tanks, :number, :string
  end
end
