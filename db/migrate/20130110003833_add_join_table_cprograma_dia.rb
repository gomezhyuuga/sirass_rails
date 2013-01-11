class AddJoinTableCprogramaDia < ActiveRecord::Migration
  def change
  	create_table :alcance_programas_cprogramas, :id => false do |t|
      t.integer :cprograma_id
      t.integer :alcance_programa_id
    end
    create_table :cprogramas_dias, :id => false do |t|
      t.integer :cprograma_id
      t.integer :dia_id
    end
  end
end
