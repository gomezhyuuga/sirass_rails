class CreatePoblacionProgramas < ActiveRecord::Migration
  def change
    create_table :poblacion_programas do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
