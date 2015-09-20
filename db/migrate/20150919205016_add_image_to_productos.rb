class AddImageToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :image, :string
  end
end
