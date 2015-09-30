class ChangePagoFromOperacion < ActiveRecord::Migration
  def change
  	change_column :operaciones, :pago, :decimal, precision: 8, scale: 2
  end
end
