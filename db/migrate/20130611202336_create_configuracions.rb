class CreateConfiguracions < ActiveRecord::Migration
  def change
    create_table :configuracions do |t|
      t.string :nombre, unique: true
      t.string :valor

      t.timestamps
    end
  end
end
