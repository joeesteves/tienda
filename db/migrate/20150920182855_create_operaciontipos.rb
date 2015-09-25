class CreateOperaciontipos < ActiveRecord::Migration
  def change
    create_table :operaciontipos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
