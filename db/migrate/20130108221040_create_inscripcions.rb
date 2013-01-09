class CreateInscripcions < ActiveRecord::Migration
  def change
    create_table :inscripcions do |t|
      t.boolean :practicas
      t.integer :estado_inscripcion_id
      t.integer :prestador_id
      t.integer :institucion_id
      t.integer :plantel_id
      t.string :carrera
      t.string :matricula
      t.integer :ano_ingreso
      t.integer :semestre
      t.float :avance_cursos
      t.float :promedio
      t.integer :nCursos_basicos
      t.integer :nCursos_superio
      t.integer :creditos
      t.string :programa_institucional
      t.string :cve_programa_institucional
      t.integer :cprograma_id
      t.string :area
      t.date :fecha_inicio
      t.date :fecha_fin
      t.time :hora_entrada
      t.time :hora_salida
      t.boolean :difundir
      t.string :responsable
      t.string :cargoResponsable
      t.string :observaciones

      t.timestamps
    end
  end
end
