class ChangeColumnObservacionesToTextOfInscripcions < ActiveRecord::Migration
  def up
  	change_column :inscripcions, :observaciones, :text
  	add_column :inscripcions, :ncontrol, :string
  end

  def down
  end
end
