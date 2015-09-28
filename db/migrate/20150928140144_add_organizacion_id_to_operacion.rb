class AddOrganizacionIdToOperacion < ActiveRecord::Migration
  def change
    add_column :operaciones, :organizacion_id, :integer
  end
end
