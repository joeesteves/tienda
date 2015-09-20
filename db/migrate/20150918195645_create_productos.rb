class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :desc
      t.references :organizacion, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
