class CreateInformeBimensuals < ActiveRecord::Migration
  def change
    create_table :informe_bimensuals do |t|
      t.integer :inscripcion_id
      t.integer :estado_reporte_id
      t.integer :numReporte
      t.date :inicioPeriodo
      t.date :terminoPeriodo
      t.integer :horasBimestre
      t.integer :minutosBimestre
      t.integer :horasAcumuladas
      t.integer :minutosAcumulados
      t.text :actividades
      t.text :observaciones
      t.datetime :created_at
      t.string :modify_by
      t.datetime :updated_at

      t.timestamps
    end
  end
end
