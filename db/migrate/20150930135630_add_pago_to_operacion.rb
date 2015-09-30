class AddPagoToOperacion < ActiveRecord::Migration
  def change
    add_column :operaciones, :pago, :decimal, precision: 8, scale: 3
  end
end
