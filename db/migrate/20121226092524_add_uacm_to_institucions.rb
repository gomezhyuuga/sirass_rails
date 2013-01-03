# -*- encoding : utf-8 -*-
class AddUacmToInstitucions < ActiveRecord::Migration
  def change
    add_column :institucions, :uacm, :boolean, default: false
  end
end
