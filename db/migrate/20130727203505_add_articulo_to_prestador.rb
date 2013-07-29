class AddArticuloToPrestador < ActiveRecord::Migration
  def change
    add_column :prestadors, :articulo_id, :integer
  end
end
