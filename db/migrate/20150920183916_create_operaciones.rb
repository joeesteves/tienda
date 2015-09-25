class CreateOperaciones < ActiveRecord::Migration
  def change
    create_table :operaciones do |t|
      t.date :fecha
      t.references :operaciontipo, index: true, foreign_key: true
      t.text :desc

      t.timestamps null: false
    end
  end
end
