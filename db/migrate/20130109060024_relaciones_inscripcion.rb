class RelacionesInscripcion < ActiveRecord::Migration
	def change
    create_table :inscripcions_dias, :id => false do |t|
      t.integer :inscripcion_id
      t.integer :dia_id
    end
  end
end
