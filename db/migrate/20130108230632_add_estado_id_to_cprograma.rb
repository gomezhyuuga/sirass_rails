class AddEstadoIdToCprograma < ActiveRecord::Migration
  def change
  	add_column :cprogramas, :estado_programa_id, :integer
  	add_column :cprogramas, :categoria_interno, :boolean, :default => true
  	add_column :cprogramas, :tiempo_indeterminado, :boolean, :default => true
  end
end
