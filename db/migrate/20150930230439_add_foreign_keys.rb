class AddForeignKeys < ActiveRecord::Migration
  def change
  	add_foreign_key :productos, :organizaciones
  	add_foreign_key :operacionitems, :operaciones
  	add_foreign_key :operacionitems, :productos
  end
end
