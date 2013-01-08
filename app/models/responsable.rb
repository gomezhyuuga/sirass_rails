# == Schema Information
#
# Table name: responsables
#
#  id           :integer          not null, primary key
#  cprograma_id :integer
#  encargado    :string(255)
#  cargo        :string(255)
#  email        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Responsable < ActiveRecord::Base
  attr_accessible :cargo, :cprograma_id, :email, :encargado

  #Relaciones
  belongs_to :cprograma

end
