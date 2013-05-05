class CreateEcontrolHoras < ActiveRecord::Migration
  def change
    create_table :econtrol_horas do |t|
      t.integer :inscripcion_id
      t.integer :estado_reporte_id
      t.integer :nReporte
      t.date :fechaInicio
      t.date :fechaFin
      t.string :supervisor
      t.integer :horasMes
      t.integer :minutosMes
      t.integer :horasAnteriores
      t.integer :minutosAnteriores
      t.integer :horasAcumuladas
      t.integer :minutosAcumulados
      t.text :observaciones
      t.datetime :created_at
      t.string :modify_by
      t.datetime :updated_at

      t.timestamps
    end
  end
end
