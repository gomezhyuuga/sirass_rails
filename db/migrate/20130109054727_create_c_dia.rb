class CreateCDia < ActiveRecord::Migration
  def change
    create_table :c_dia do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
