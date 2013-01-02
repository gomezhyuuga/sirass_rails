class CreateInstitucionUsers < ActiveRecord::Migration
  def change
    create_table :institucion_users do |t|
      t.integer :institucion_id, null: false
      t.integer :plantel_id, null: false
      t.string :domicilio, null: false
      t.string :area, null: false
      t.string :responsable, null: false
      t.string :cargo, null: false
      t.string :tel, null: false
      t.string :telExt, null: false

      t.timestamps
    end
  end
end
