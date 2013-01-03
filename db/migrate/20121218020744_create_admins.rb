# -*- encoding : utf-8 -*-
class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :nombre, null: false
      t.string :aPaterno, null: false
      t.string :aMaterno, null: false
      t.date :nacimiento, null: false
      t.string :cargo, null: false

      t.timestamps
    end
  end
end
