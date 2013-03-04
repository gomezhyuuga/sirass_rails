class CreateControlHoras < ActiveRecord::Migration
  def change
    create_table :control_horas do |t|
      t.integer :id_inscripcion
      t.integer :id_estado_reporte
      t.integer :numReporte
      t.date :fechaInicio
      t.date :fechaFin
      t.string :supervisor
      t.integer :horasMes
      t.integer :horasAnteriores
      t.integer :horasAcumuladas
      t.integer :minutosMes
      t.integer :minutosAnteriores
      t.integer :minutosAcumulados
      t.string :observaciones

      t.timestamps
    end
  end
end
