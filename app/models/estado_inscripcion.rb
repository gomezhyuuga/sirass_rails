# == Schema Information
#
# Table name: estado_inscripcions
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# == ESTADOS ==
# 1,"Esperando validación"
# 2,"En servicio"
# 3,"Suspensión temporal"
# 4,"Dado de baja"
# 5,"Finalizado"
# 6,"Con errores"
# 7,"Correcta"

class EstadoInscripcion < ActiveRecord::Base
	VALIDANDO		= 1
	EN_SERVICIO	= 2
	SUSPENDIDO	= 3
	BAJA				= 4
	FINALIZADO	= 5
	ERRORES			= 6
	CORRECTA		= 7

  attr_accessible :descripcion

  # Relaciones
  has_and_belongs_to_many :cprogramas

  # Abstracción de estados
  def validando?
  	self.id == VALIDANDO
  end
  def en_servicio?
  	self.id == EN_SERVICIO
  end
  def suspendida?
  	self.id == SUSPENDIDO
  end
  def dado_de_baja?
  	self.id == BAJA
  end
  def servicio_finalizado?
  	self.id == FINALIZADO
  end
  def con_errores?
  	self.id == ERRORES
  end
  def correcta?
  	self.id == CORRECTA
  end
end
