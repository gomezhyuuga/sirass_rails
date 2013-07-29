# encoding: UTF-8
# == Schema Information
#
# Table name: econtrol_horas
#
#  id                :integer          not null, primary key
#  inscripcion_id    :integer
#  estado_reporte_id :integer
#  nReporte          :integer
#  fechaInicio       :date
#  fechaFin          :date
#  supervisor        :string(255)
#  horasMes          :integer
#  minutosMes        :integer
#  horasAnteriores   :integer
#  minutosAnteriores :integer
#  horasAcumuladas   :integer
#  minutosAcumulados :integer
#  observaciones     :text
#  created_at        :datetime         not null
#  modify_by         :string(255)
#  updated_at        :datetime         not null
#

class EcontrolHora < ActiveRecord::Base
  attr_accessible :estado_reporte_id, :fechaFin, :fechaInicio, :horasAcumuladas, :horasAnteriores, :horasMes,
	:minutosAcumulados, :minutosAnteriores, :minutosMes, :modify_by, :nReporte, :observaciones, :supervisor, 
	:updated_at
end
