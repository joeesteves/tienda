class CreateOperacionitems < ActiveRecord::Migration
  def change
    create_table :operacionitems do |t|
      t.references :producto, index: true, foreign_key: true
      t.decimal :cantidad, precision: 10, scale: 2
      t.decimal :precio, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
