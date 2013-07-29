class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.integer :estado_inscripcion_id
      t.integer :prestador_id
      t.string :Dependencia
      t.string :Area
      t.string :Puesto
      t.date :Fecha_Ingreso
      t.string :Contratacion
      t.string :Jefe_inmediato
      t.string :Cargo

      t.timestamps
    end
  end
end
