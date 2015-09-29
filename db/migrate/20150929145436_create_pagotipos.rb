class CreatePagotipos < ActiveRecord::Migration
  def change
    create_table :pagotipos do |t|
      t.string :nombre
      t.decimal :factor, precision: 5, scale: 2, default: 1
      t.timestamps null: false
    end
  end
end
