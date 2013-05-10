class CreateMonthlyReportHours < ActiveRecord::Migration
  def change
    create_table :monthly_report_hours do |t|
      t.integer :monthly_report_id
      t.date :fecha
      t.time :entrada
      t.time :salida

      t.timestamps
    end
  end
end
