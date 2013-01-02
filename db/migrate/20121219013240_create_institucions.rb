class CreateInstitucions < ActiveRecord::Migration
  def change
    create_table :institucions do |t|
      t.string :nombre, null: false
      t.boolean :educativa, default: false

      t.timestamps
    end
  end
end
