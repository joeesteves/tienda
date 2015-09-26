class AddTotalToOperacion < ActiveRecord::Migration
  def change
    add_column :operaciones, :total, :decimal, precision: 8, scale: 2
  end
end
