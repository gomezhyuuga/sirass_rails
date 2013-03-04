class CreateControlHoras < ActiveRecord::Migration
  def change
    create_table :control_horas do |t|
      t.integer :iinscripcion_id
      t.integer :estado_reporte_id
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
