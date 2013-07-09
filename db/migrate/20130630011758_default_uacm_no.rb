class DefaultUacmNo < ActiveRecord::Migration
  def up
  	change_column :prestadors, :estudiante_uacm, :boolean, :default => false
  end

  def down
  	change_column :prestadors, :estudiante_uacm, :boolean
  end
end
