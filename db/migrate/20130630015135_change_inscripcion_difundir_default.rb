class ChangeInscripcionDifundirDefault < ActiveRecord::Migration
  def up
  	change_column :inscripcions, :difundir, :boolean, :default => true
  end

  def down
  	change_column :inscripcions, :difundir, :boolean
  end
end
