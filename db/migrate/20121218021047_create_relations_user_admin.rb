# -*- encoding : utf-8 -*-
class CreateRelationsUserAdmin < ActiveRecord::Migration
  def up
  	add_column :users, :admin_id, :integer
  end

  def down
  	remove_column :users, :admin_id, :integer
  end
end
