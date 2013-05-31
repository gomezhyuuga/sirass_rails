class ChangeObservacionesToText < ActiveRecord::Migration
  def change
  	change_column :monthly_reports, :observaciones, :text
  end
end
