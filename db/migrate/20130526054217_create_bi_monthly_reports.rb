class CreateBiMonthlyReports < ActiveRecord::Migration
  def change
    create_table :bi_monthly_reports do |t|
      t.integer :inscripcion_id
      t.integer :estado_reporte_id
      t.integer :numero
      t.date :periodo_inicio
      t.date :periodo_fin
      t.string :horas
      t.string :horas_anteriores
      t.string :horas_acumuladas
      t.text :actividades
      t.text :observaciones

      t.timestamps
    end
  end
end
