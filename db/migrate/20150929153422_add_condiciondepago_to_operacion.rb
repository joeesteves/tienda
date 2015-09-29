class AddCondiciondepagoToOperacion < ActiveRecord::Migration
  def change
    add_column :operaciones, :pagotipo_id, :integer
  end
end
