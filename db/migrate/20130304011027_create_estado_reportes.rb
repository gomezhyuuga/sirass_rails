class CreateEstadoReportes < ActiveRecord::Migration
  def change
    create_table :estado_reportes do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
