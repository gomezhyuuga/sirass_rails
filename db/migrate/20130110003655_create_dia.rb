class CreateDia < ActiveRecord::Migration
  def change
    create_table :dias do |t|
      t.string :dia_semana

      t.timestamps
    end
  end
end
