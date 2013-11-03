class AddPaseoToInstitucionUser < ActiveRecord::Migration
  def change
  	add_column :institucion_users, :paseo, :boolean, :default => false
  end
end
