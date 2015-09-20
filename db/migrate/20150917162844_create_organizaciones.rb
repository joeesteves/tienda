class CreateOrganizaciones < ActiveRecord::Migration
  def change
    create_table :organizaciones do |t|
      t.string :nombre
      t.string :id_fiscal
      t.string :email
      t.string :telefono
      t.text :desc

      t.timestamps null: false
    end
  end
end
