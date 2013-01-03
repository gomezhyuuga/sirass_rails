# -*- encoding : utf-8 -*-
class AddInstitucionUserIdToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :institucion_user_id, :integer
  end

  def down
  	remove_column :users, :institucion_user_id, :integer
  end
end
