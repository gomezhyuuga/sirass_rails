class ChangeLimitOfNombreForCprogramas < ActiveRecord::Migration
  def up
  	change_column :cprogramas, :nombre, :string, :limit => 600
  	change_column :cprogramas, :lugar, :string, :limit => 1000
  end

  def down
  end
end
