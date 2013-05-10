class CreateMonthlyReports < ActiveRecord::Migration
  def change
    create_table :monthly_reports do |t|
      t.integer :numero
      t.integer :inscripcion_id
      t.integer :estado_reporte_id
      t.string :horas
      t.string :horas_acum
      t.string :horas_anteriores
      t.string :supervisor
      t.date :fecha_inicio
      t.date :fecha_fin
      t.string :observaciones

      t.timestamps
    end
  end
end
