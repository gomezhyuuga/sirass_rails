class CreateHorarioProgramas < ActiveRecord::Migration
  def change
    create_table :horario_programas do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
