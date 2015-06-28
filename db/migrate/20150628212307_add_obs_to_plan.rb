class AddObsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :obs, :string
  end
end
