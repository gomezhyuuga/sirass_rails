class CreateEstadoProgramas < ActiveRecord::Migration
  def change
    create_table :estado_programas do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
