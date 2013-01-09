class AddColumnaToCprograma < ActiveRecord::Migration
  def change
  	rename_column :cprogramas, :status_id, :estado_programa_id
  	rename_column :cprogramas, :horario_id, :horario_programa_id
  	remove_column :cprogramas, :tiempo_id
  end
end
