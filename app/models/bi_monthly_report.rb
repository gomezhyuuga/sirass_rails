# == Schema Information
#
# Table name: bi_monthly_reports
#
#  id                :integer          not null, primary key
#  inscripcion_id    :integer
#  estado_reporte_id :integer
#  numero            :integer
#  periodo_inicio    :date
#  periodo_fin       :date
#  horas             :string(255)
#  horas_anteriores  :string(255)
#  horas_acumuladas  :string(255)
#  actividades       :text
#  observaciones     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class BiMonthlyReport < ActiveRecord::Base
  attr_accessible :actividades, :estado_reporte_id, :horas, :horas_anteriores, :horas_acumuladas, :inscripcion_id, :numero, :observaciones, :periodo_fin, :periodo_inicio

  validates_presence_of :actividades, :estado_reporte_id, :horas, :horas_anteriores, :horas_acumuladas, :inscripcion_id, :numero, :periodo_fin, :periodo_inicio

  belongs_to :estado_reporte
  belongs_to :inscripcion
  after_save :update_horas_servicio
  after_destroy :update_horas_servicio

  private
	  def update_horas_servicio
	  	self.inscripcion.calcular_horas_servicio
	  end
end
