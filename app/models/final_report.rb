# == Schema Information
#
# Table name: final_reports
#
#  id                :integer          not null, primary key
#  inscripcion_id    :integer
#  estado_reporte_id :integer
#  horas             :string(255)
#  introduccion      :text
#  obj_gral          :text
#  obj_esp           :text
#  metodologia       :text
#  actividades       :text
#  metas             :text
#  resultados        :text
#  observaciones     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class FinalReport < ActiveRecord::Base
  attr_accessible :actividades, :estado_reporte_id, :horas, :inscripcion_id, :introduccion,
  	:metas, :metodologia, :obj_esp, :obj_gral, :observaciones, :resultados

  validates_presence_of :actividades, :estado_reporte_id, :horas, :inscripcion_id, :introduccion,
  	:metas, :metodologia, :obj_esp, :obj_gral, :resultados

  belongs_to :inscripcion
  belongs_to :estado_reporte
  
end
