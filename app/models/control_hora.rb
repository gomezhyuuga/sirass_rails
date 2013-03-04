# encoding: utf-8
# == Schema Information
#
# Table name: control_horas
#
#  id                :integer          not null, primary key
#  iinscripcion_id   :integer
#  estado_reporte_id :integer
#  numReporte        :integer
#  fechaInicio       :date
#  fechaFin          :date
#  supervisor        :string(255)
#  horasMes          :integer
#  horasAnteriores   :integer
#  horasAcumuladas   :integer
#  minutosMes        :integer
#  minutosAnteriores :integer
#  minutosAcumulados :integer
#  observaciones     :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#


class ControlHora < ActiveRecord::Base
  attr_accessible :fechaFin, :fechaInicio, :horasAcumuladas, :horasAnteriores, :horasMes, :estado_reporte_id, :inscripcion_id, :minutosAcumulados, :minutosAnteriores, :minutosMes, :numReporte, :observaciones, :supervisor

  belongs_to :inscripcion
end
