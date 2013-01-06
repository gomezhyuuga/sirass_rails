# == Schema Information
#
# Table name: licenciaturas
#
#  id           :integer          not null, primary key
#  cprograma_id :integer
#  carrera      :string(255)
#  actividad    :string(255)
#  solicitados  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Licenciatura < ActiveRecord::Base
  attr_accessible :actividad, :carrera, :solicitados

  #Relaciones
  belongs_to :cprograma

end
