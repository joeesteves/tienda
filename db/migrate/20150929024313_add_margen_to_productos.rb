class AddMargenToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :margen, :decimal, precision: 5, scale: 2
  end
end
