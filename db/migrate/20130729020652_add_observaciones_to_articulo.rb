class AddObservacionesToArticulo < ActiveRecord::Migration
  def change
  	add_column :articulos, :Observaciones, :text
  end
end
