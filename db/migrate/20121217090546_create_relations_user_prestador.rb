class CreateRelationsUserPrestador < ActiveRecord::Migration
  def up
  	add_column :users, :prestador_id, :integer
  end

  def down
  	remove_column :users, :prestador_id
  end
end
