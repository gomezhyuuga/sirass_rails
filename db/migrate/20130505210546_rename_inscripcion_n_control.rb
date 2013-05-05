class RenameInscripcionNControl < ActiveRecord::Migration
  def up
  	rename_column :inscripcions, :nControl, :ncontrol
  end

  def down
  end
end
