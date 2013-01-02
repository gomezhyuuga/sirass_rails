class CompleteFieldsForPrestador < ActiveRecord::Migration
  def up
  	add_column :prestadors, :sexo, :string
	  add_column :prestadors, :dCalle, :string
	  add_column :prestadors, :dNumExt, :string
	  add_column :prestadors, :dNumInt, :string
	  add_column :prestadors, :dCP, :string
	  add_column :prestadors, :dDelegacion, :string
	  add_column :prestadors, :dColonia, :string
	  add_column :prestadors, :telCasa, :string
	  add_column :prestadors, :telCel, :string
  end

  def down
  	remove_column :prestadors, :sexo, :string
	  remove_column :prestadors, :dCalle, :string
	  remove_column :prestadors, :dNumExt, :string
	  remove_column :prestadors, :dNumInt, :string
	  remove_column :prestadors, :dCP, :string
	  remove_column :prestadors, :dDelegacion, :string
	  remove_column :prestadors, :dColonia, :string
	  remove_column :prestadors, :telCasa, :string
	  remove_column :prestadors, :telCel, :string
  end
end
