class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
      t.integer :cprograma_id
      t.string :encargado
      t.string :cargo
      t.string :email

      t.timestamps
    end
  end
end
