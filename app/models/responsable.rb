class Responsable < ActiveRecord::Base
  attr_accessible :cargo, :cprograma_id, :email, :encargado

  #Relaciones
  belongs_to :cprograma

end
