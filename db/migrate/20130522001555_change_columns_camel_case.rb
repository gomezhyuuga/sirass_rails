class ChangeColumnsCamelCase < ActiveRecord::Migration
  def change
  	rename_column :prestadors, :aPaterno, :apaterno
  	rename_column :prestadors, :aMaterno, :amaterno
  	rename_column :admins, :aPaterno, :apaterno
  	rename_column :admins, :aMaterno, :amaterno
  end
end
