class AddTipoIdToCprograma < ActiveRecord::Migration
  def change
  	add_column :cprogramas, :tipo_programa_id, :integer
  end
end
