class CreateFinalReports < ActiveRecord::Migration
  def change
    create_table :final_reports do |t|
      t.integer :inscripcion_id
      t.integer :estado_reporte_id
      t.string :horas
      t.text :introduccion
      t.text :obj_gral
      t.text :obj_esp
      t.text :metodologia
      t.text :actividades
      t.text :metas
      t.text :resultados
      t.text :observaciones

      t.timestamps
    end
  end
end
