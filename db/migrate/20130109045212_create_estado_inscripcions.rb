class CreateEstadoInscripcions < ActiveRecord::Migration
  def change
    create_table :estado_inscripcions do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
