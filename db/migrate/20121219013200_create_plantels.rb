# -*- encoding : utf-8 -*-
class CreatePlantels < ActiveRecord::Migration
  def change
    create_table :plantels do |t|
      t.integer :institucion_id, null: false
      t.string :nombre, null: false

      t.timestamps
    end
  end
end
