class CreateDia < ActiveRecord::Migration
  def change
    create_table :dia do |t|
      t.string :dia_semana

      t.timestamps
    end
  end
end
