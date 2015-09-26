class ChangeCantidadFormOperacionitems < ActiveRecord::Migration
  def change
  	change_column :operacionitems, :cantidad, :integer
  end
end
