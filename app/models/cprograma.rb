# == Schema Information
#
# Table name: cprogramas
#
#  id               :integer          not null, primary key
#  institucion_id   :integer
#  cveprograma      :string(255)
#  categoria_id     :integer
#  status_id        :integer
#  nombre           :string(255)
#  objGeneral       :text
#  justificacion    :text
#  desarrollo       :text
#  recursos         :text
#  evaluacion       :text
#  resultados       :text
#  lugar            :string(255)
#  horario_id       :integer
#  plazas           :integer
#  vacantes         :integer
#  observaciones    :text
#  notas            :text
#  tiempo_id        :integer
#  ftiempo          :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tipo_programa_id :integer
#

class Cprograma < ActiveRecord::Base
  attr_accessible :categoria_id, :cveprograma, :desarrollo, :evaluacion, :ftiempo, 
  :horario_id, :institucion_id, :justificacion, :lugar, :nombre, :notas, :objGeneral, 
  :observaciones, :plazas, :recursos, :resultados, :status_id, :tiempo_id, :vacantes, :tipo_programa_id,
  :licenciaturas_attributes, :responsables_attributes

  #Validaciones
  validates_presence_of :desarrollo, :evaluacion, :justificacion, :lugar, :nombre, :objGeneral, 
  :observaciones, :recursos, :resultados, :tipo_programa_id

  #Relaciones
  has_many :licenciaturas
  has_many :responsables
  accepts_nested_attributes_for :licenciaturas
  accepts_nested_attributes_for :responsables

  belongs_to :tipo_programa
  	
end
