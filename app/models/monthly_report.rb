# encoding: UTF-8
# == Schema Information
#
# Table name: monthly_reports
#
#  id                :integer          not null, primary key
#  numero            :integer
#  inscripcion_id    :integer
#  estado_reporte_id :integer
#  horas             :string(255)
#  horas_acum        :string(255)
#  horas_anteriores  :string(255)
#  supervisor        :string(255)
#  fecha_inicio      :date
#  fecha_fin         :date
#  observaciones     :text(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReport < ActiveRecord::Base
  attr_accessible :estado_reporte_id, :fecha_fin, :fecha_inicio, :horas, :horas_acum, :horas_anteriores, :inscripcion_id, :numero, :observaciones, :supervisor, :monthly_report_hours_attributes

  validates_presence_of :fecha_fin, :fecha_inicio, :horas, :horas_acum, :horas_anteriores, :inscripcion_id, :numero, :supervisor

  validates :numero, numericality: { only_integer: true, greater_than: 0, less_than: 11 }

  belongs_to :inscripcion
  belongs_to :estado_reporte
  has_many :monthly_report_hours, dependent: :destroy
  accepts_nested_attributes_for :monthly_report_hours, allow_destroy: true
  validates_associated :monthly_report_hours

  after_save :update_horas_servicio
  after_destroy :update_horas_servicio

  private
	  def update_horas_servicio
	  	self.inscripcion.calcular_horas_servicio
	  end
end
