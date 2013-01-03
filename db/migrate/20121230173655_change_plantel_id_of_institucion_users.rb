# -*- encoding : utf-8 -*-
class ChangePlantelIdOfInstitucionUsers < ActiveRecord::Migration
  def up
  	change_column :institucion_users, :plantel_id, :integer, :null => :true
  end

  def down
  end
end
