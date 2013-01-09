class RemoveColumnToCprograma < ActiveRecord::Migration
  def change
  	remove_column :cprogramas, :categoria_id
  end
end
