# encoding: UTF-8
# == Schema Information
#
# Table name: alcance_programas
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AlcancePrograma < ActiveRecord::Base
  attr_accessible :descripcion

  has_and_belongs_to_many :cprogramas
  
end
