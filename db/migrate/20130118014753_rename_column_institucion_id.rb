class RenameColumnInstitucionId < ActiveRecord::Migration
  def change
  	rename_column :cprogramas, :institucion_id, :institucion_user_id
  end
end
