# == Schema Information
#
# Table name: cprogramas
#
#  id                   :integer          not null, primary key
#  institucion_user_id  :integer
#  cveprograma          :string(255)
#  categoria_id         :integer
#  status_id            :integer
#  nombre               :string(255)
#  objGeneral           :text
#  justificacion        :text
#  desarrollo           :text
#  recursos             :text
#  evaluacion           :text
#  resultados           :text
#  lugar                :text(255)
#  horario_programa_id  :integer
#  plazas               :integer
#  vacantes             :integer
#  observaciones        :text
#  notas                :text
#  ftiempo              :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  tipo_programa_id     :integer
#  estado_programa_id   :integer
#  categoria_interno    :boolean          default(TRUE)
#  tiempo_indeterminado :boolean          default(TRUE)
#

class Cprograma < ActiveRecord::Base
  attr_accessible :cveprograma, :desarrollo, :evaluacion, :ftiempo, :tiempo_indeterminado, 
  :horario_programa_id, :institucion_user_id, :justificacion, :lugar, :nombre, :notas, :objGeneral, 
  :observaciones, :plazas, :recursos, :resultados, :estado_programa_id, :tiempo_id, :vacantes, :tipo_programa_id,
  :licenciaturas_attributes, :responsables_attributes, :alcance_programa_ids, :poblacion_programa_ids, :dia_ids, :categoria_interno

  #Validaciones
  validates_presence_of :desarrollo, :evaluacion, :justificacion, :lugar, :nombre, :objGeneral,
    :recursos, :resultados, :tipo_programa_id

  validates :tiempo_indeterminado, :inclusion => {:in => [true, false]}

  #Relaciones

  has_and_belongs_to_many :poblacion_programas
  has_and_belongs_to_many :alcance_programas
  has_and_belongs_to_many :dias

  has_many :licenciaturas, dependent: :destroy
  has_many :responsables, dependent: :destroy
  has_many :inscripcions, dependent: :destroy
  accepts_nested_attributes_for :licenciaturas
  accepts_nested_attributes_for :responsables

  belongs_to :tipo_programa
  belongs_to :estado_programa
  belongs_to :horario_programa

  belongs_to :institucion_user
  
  # Devuelve interno o externo como string dependiendo de la categoría
  def categoria
    categoria = self.categoria_interno == true ? "Interno" : "Externo"
  end

  # Obtener totales de programas por categoría y estado INTERNO
  def self.total_internos
    Cprograma.where(categoria_interno: true).count
  end
  def self.total_internos_activos
    self.find_int_ext_by_estado(true, EstadoPrograma::ACTIVO)
  end
  def self.total_internos_inactivos
    self.find_int_ext_by_estado(true, EstadoPrograma::INACTIVO)
  end
  def self.total_internos_esperando
    self.find_int_ext_by_estado(true, EstadoPrograma::ESPERANDO)
  end
  def self.total_internos_suspendidos
    self.find_int_ext_by_estado(true, EstadoPrograma::SUSPENDIDO)
  end
  def self.total_internos_observaciones
    self.find_int_ext_by_estado(true, EstadoPrograma::OBSERVACION)
  end
  def self.total_internos_actualizados
    self.find_int_ext_by_estado(true, EstadoPrograma::ACTUALIZADO)
  end

  # Obtener totales de programas por categoría y estado EXTERNO
  def self.total_externos
    Cprograma.where(categoria_interno: false).count
  end
  def self.total_externos_activos
    self.find_int_ext_by_estado(false, EstadoPrograma::ACTIVO)
  end
  def self.total_externos_inactivos
    self.find_int_ext_by_estado(false, EstadoPrograma::INACTIVO)
  end
  def self.total_externos_esperando
    self.find_int_ext_by_estado(false, EstadoPrograma::ESPERANDO)
  end
  def self.total_externos_suspendidos
    self.find_int_ext_by_estado(false, EstadoPrograma::SUSPENDIDO)
  end
  def self.total_externos_observaciones
    self.find_int_ext_by_estado(false, EstadoPrograma::OBSERVACION)
  end
  def self.total_externos_actualizados
    self.find_int_ext_by_estado(false, EstadoPrograma::ACTUALIZADO)
  end


  private
    def self.find_int_ext_by_estado(is_interno, estado)
      Cprograma.all(conditions: ["categoria_interno = ? AND estado_programa_id = ?", is_interno, estado]).count
    end
end
