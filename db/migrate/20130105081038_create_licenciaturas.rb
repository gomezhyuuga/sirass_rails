class CreateLicenciaturas < ActiveRecord::Migration
  def change
    create_table :licenciaturas do |t|
      t.integer :cprograma_id
      t.string :carrera
      t.string :actividad
      t.integer :solicitados

      t.timestamps
    end
  end
end
