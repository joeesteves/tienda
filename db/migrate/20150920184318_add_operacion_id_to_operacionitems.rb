class AddOperacionIdToOperacionitems < ActiveRecord::Migration
  def change
    add_column :operacionitems, :operacion_id, :integer
  end
end
