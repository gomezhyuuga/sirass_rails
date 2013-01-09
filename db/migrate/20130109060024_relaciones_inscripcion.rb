class RelacionesInscripcion < ActiveRecord::Migration
	def change
    create_table :inscripcions_c_dias, :id => false do |t|
      t.integer :inscripcion_id
      t.integer :c_dia_id
    end
  end
end
