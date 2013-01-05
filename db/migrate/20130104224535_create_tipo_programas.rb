class CreateTipoProgramas < ActiveRecord::Migration
  def change
    create_table :tipo_programas do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
