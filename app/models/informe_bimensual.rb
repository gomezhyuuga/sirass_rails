# == Schema Information
#
# Table name: informe_bimensuals
#
#  id                :integer          not null, primary key
#  inscripcion_id    :integer
#  estado_reporte_id :integer
#  numReporte        :integer
#  inicioPeriodo     :date
#  terminoPeriodo    :date
#  horasBimestre     :integer
#  minutosBimestre   :integer
#  horasAcumuladas   :integer
#  minutosAcumulados :integer
#  actividades       :text
#  observaciones     :text
#  created_at        :datetime         not null
#  modify_by         :string(255)
#  updated_at        :datetime         not null
#

class InformeBimensual < ActiveRecord::Base
  attr_accessible :actividades, :horasAcumuladas, :horasBimestre, :inicioPeriodo, :minutosAcumulados, :minutosBimestre, :numReporte, :terminoPeriodo

  #Relaciones
  belongs_to :inscripcion
  belongs_to :estado_reporte
end
