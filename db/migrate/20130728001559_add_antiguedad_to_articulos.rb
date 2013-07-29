class AddAntiguedadToArticulos < ActiveRecord::Migration
  def change
    add_column :articulos, :antiguedad, :string
  end
end
