class CreateAlcanceProgramas < ActiveRecord::Migration
  def change
    create_table :alcance_programas do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
