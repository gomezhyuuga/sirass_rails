class CreatePrestadors < ActiveRecord::Migration
  def change
    create_table :prestadors do |t|
      t.string :nombre, null: false
      t.string :aPaterno, null: false
      t.string :aMaterno, null: false
      t.date :nacimiento, null: false

      t.timestamps
    end
  end
end
