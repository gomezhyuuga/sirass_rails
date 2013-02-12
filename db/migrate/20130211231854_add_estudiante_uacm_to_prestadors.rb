class AddEstudianteUacmToPrestadors < ActiveRecord::Migration
  def change
  	add_column :prestadors, :estudiante_uacm, :boolean
  	add_column :prestadors, :inscripcion_actual, :id
  end
end
