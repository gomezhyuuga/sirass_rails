# == Schema Information
#
# Table name: estado_programas
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# == ESTADOS ==
# 1,"Activo"
# 2,"Inactivo"
# 3,"Suspendido"
# 4,"Esperando"
# 5,"Actualizado"
# 6,"Observación"

class EstadoPrograma < ActiveRecord::Base
  attr_accessible :descripcion
  
  has_and_belongs_to_many :cprogramas

  # CONST
  ACTIVO 			= 1
  INACTIVO 		= 2
  SUSPENDIDO 	= 3
  ESPERANDO 	= 4
  ACTUALIZADO = 5
  OBSERVACION = 6
end