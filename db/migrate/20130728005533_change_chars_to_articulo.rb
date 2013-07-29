class ChangeCharsToArticulo < ActiveRecord::Migration
  def up
  	change_column :articulos, :Dependencia, :string, :limit => 700
  	change_column :articulos, :Area, :string, :limit => 700
  	change_column :articulos, :Jefe_inmediato, :string, :limit => 700
  end

  def down
  end
end
