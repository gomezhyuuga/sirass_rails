# encoding: UTF-8
# == Schema Information
#
# Table name: estado_reportes
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EstadoReporte < ActiveRecord::Base
  attr_accessible :descripcion

  # Relaciones
  has_and_belongs_to_many :control_horas

  # CONSTANTES
  SIN_REVISION 	= 1
  CON_ERRORES 	= 2
  CORRECTO 			= 3
  ACTUALIZADO 	= 4
end
