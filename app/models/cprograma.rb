# == Schema Information
#
# Table name: cprogramas
#
#  id                   :integer          not null, primary key
#  institucion_id       :integer
#  cveprograma          :string(255)
#  estado_programa_id   :integer
#  nombre               :string(255)
#  objGeneral           :text
#  justificacion        :text
#  desarrollo           :text
#  recursos             :text
#  evaluacion           :text
#  resultados           :text
#  lugar                :string(255)
#  horario_programa_id  :integer
#  plazas               :integer
#  vacantes             :integer
#  observaciones        :text
#  notas                :text
#  ftiempo              :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  tipo_programa_id     :integer
#  categoria_interno    :boolean          default(TRUE)
#  tiempo_indeterminado :boolean          default(TRUE)
#

class Cprograma < ActiveRecord::Base
  attr_accessible :cveprograma, :desarrollo, :evaluacion, :ftiempo, 
  :horario_programa_id, :institucion_id, :justificacion, :lugar, :nombre, :notas, :objGeneral, 
  :observaciones, :plazas, :recursos, :resultados, :estado_programa_id, :tiempo_id, :vacantes, :tipo_programa_id,
  :licenciaturas_attributes, :responsables_attributes

  #Validaciones
  validates_presence_of :desarrollo, :evaluacion, :justificacion, :lugar, :nombre, :objGeneral, 
  :observaciones, :recursos, :resultados, :tipo_programa_id

  #Relaciones

  has_and_belongs_to_many :poblacion_programas
  has_and_belongs_to_many :alcance_programa

  has_many :licenciaturas, dependent: :destroy
  has_many :responsables, dependent: :destroy
  accepts_nested_attributes_for :licenciaturas
  accepts_nested_attributes_for :responsables

  belongs_to :tipo_programa
  belongs_to :estado_programa
  	
end
