class CreateCprogramas < ActiveRecord::Migration
  def change
    create_table :cprogramas do |t|
      t.integer :institucion_id
      t.string :cveprograma
      t.integer :categoria_id
      t.integer :status_id
      t.string :nombre
      t.text :objGeneral
      t.text :justificacion
      t.text :desarrollo
      t.text :recursos
      t.text :evaluacion
      t.text :resultados
      t.string :lugar
      t.integer :horario_id
      t.integer :plazas
      t.integer :vacantes
      t.text :observaciones
      t.text :notas
      t.integer :tiempo_id
      t.date :ftiempo

      t.timestamps
    end
    add_index :cprogramas, :cveprograma 
  end
end
