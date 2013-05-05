class CreateDcontrolHoras < ActiveRecord::Migration
  def change
    create_table :dcontrol_horas do |t|
      t.integer :control_hora_id
      t.date :fecha
      t.time :Hora_Entrada
      t.time :Hora_Salida
      t.time :Horas_Dia

      t.timestamps
    end
  end
end
