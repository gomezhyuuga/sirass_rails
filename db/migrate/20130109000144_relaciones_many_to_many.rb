class RelacionesManyToMany < ActiveRecord::Migration
  def change
    create_table :cprogramas_poblacion_programas, :id => false do |t|
      t.integer :cprograma_id
      t.integer :poblacion_programa_id
    end
  end
end
