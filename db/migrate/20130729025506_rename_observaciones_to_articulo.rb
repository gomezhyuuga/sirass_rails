class RenameObservacionesToArticulo < ActiveRecord::Migration
  def up
  	rename_column :articulos, :Observaciones, :observaciones
  end

  def down
  end
end
