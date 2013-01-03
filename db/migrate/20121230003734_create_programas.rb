# -*- encoding : utf-8 -*-
class CreateProgramas < ActiveRecord::Migration
  def change
    create_table :programas do |t|
      t.string :cvePrograma
      t.string :nombre
      t.text :objetivoGeneral
      t.text :justificacion
      t.text :desarrollo
      t.text :recursos
      t.text :evaluacion
      t.text :resultados
      t.string :lugar
      t.integer :plazas
      t.integer :ocupadas
      t.text :observaciones
      t.text :notas

      t.timestamps
    end

    add_index :programas, :cvePrograma, unique: true
  end
end
