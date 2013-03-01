class CorreccionesCamposPrograma < ActiveRecord::Migration
  def change
  	change_column :cprogramas, :lugar, :text
  	change_column :licenciaturas, :actividad, :text
  end
end
