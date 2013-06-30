class AddArticulo91ToInscripcions < ActiveRecord::Migration
  def change
  	add_column :inscripcions, :articulo_91, :boolean, :default => false
  end
end
