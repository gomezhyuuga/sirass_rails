class RemoveArticulo91ToInscripcion < ActiveRecord::Migration
  def up
  	remove_column :inscripcions, :articulo_91
  end

  def down
  end
end
