class ChangeMargenToProductos < ActiveRecord::Migration
  def change
  	change_column :productos, :margen, :decimal, precision: 5, scale:2, default: 1
  end
end
