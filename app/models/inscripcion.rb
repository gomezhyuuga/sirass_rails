# encoding: utf-8
# == Schema Information
#
# Table name: inscripcions
#
#  id                         :integer          not null, primary key
#  practicas                  :boolean
#  estado_inscripcion_id      :integer
#  prestador_id               :integer
#  institucion_id             :integer
#  plantel_id                 :integer
#  carrera                    :string(255)
#  matricula                  :string(255)
#  ano_ingreso                :integer
#  semestre                   :integer
#  avance_cursos              :float
#  promedio                   :float
#  nCursos_basicos            :integer
#  nCursos_superio            :integer
#  creditos                   :integer
#  programa_institucional     :string(255)
#  cve_programa_institucional :string(255)
#  cprograma_id               :integer
#  area                       :string(255)
#  fecha_inicio               :date
#  fecha_fin                  :date
#  hora_entrada               :time
#  hora_salida                :time
#  difundir                   :boolean          default(TRUE)
#  responsable                :string(255)
#  cargoResponsable           :string(255)
#  observaciones              :text(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  ncontrol                   :string(255)
#  articulo_91                :boolean          default(FALSE)
#  horas_servicio             :string(255)      default("00:00")
#

class Inscripcion < ActiveRecord::Base
  attr_accessible :ano_ingreso, :area, :avance_cursos, :cargoResponsable,
  :carrera, :cprograma_id, :creditos, :cve_programa_institucional, :difundir,
  :estado_inscripcion_id, :fecha_fin, :fecha_inicio, :hora_entrada, :hora_salida,
  :institucion_id, :matricula, :nCursos_basicos, :nCursos_superio, :observaciones,
  :plantel_id, :practicas, :prestador_id, :programa_institucional, :promedio, :responsable,
  :semestre, :dia_ids, :institucion_attributes, :ncontrol, :articulo_91, :horas_servicio

  validates_presence_of :prestador_id, :institucion, :plantel_id, :carrera, :matricula,
  :semestre, :ano_ingreso, :avance_cursos, :promedio, :cprograma_id, :fecha_inicio,
  :fecha_fin, :responsable, :dia_ids, :area, :hora_entrada, :hora_salida, :cargoResponsable

  # Relaciones
  belongs_to :prestador
  belongs_to :inscripcion
  belongs_to :institucion
  belongs_to :plantel
  belongs_to :cprograma
  belongs_to :estado_inscripcion
  after_destroy :delete_prestador_relation

  accepts_nested_attributes_for :institucion

  has_and_belongs_to_many :dias, join_table: :inscripcions_dias
  has_many :monthly_reports, dependent: :destroy
  has_many :bi_monthly_reports, dependent: :destroy
  def tipo_inscripcion
    if self.practicas?
      "Práctica Profesional"
    else
      "Servicio Social"
    end
  end

  def tipo_servicio
    self.practicas ? "Práctica Profesional" : "Servicio Social"
  end

  def nombre_plantel
    self.plantel.nombre if self.plantel
  end

  def articulo_91_to_s
    self.articulo_91 == true ? "Sí" : "No"
  end

  def calcular_horas_servicio
    horas = 0
    mins = 0
    # Acumular horas y mins
    self.monthly_reports.each do |r|
      horas += r.horas.split(':').first.to_i
      mins += r.horas.split(':').last.to_i
    end

    # Convertir mins sobrantes a horas
    horas += mins / 60
    mins = mins % 60

    self.update_attribute(:horas_servicio, "%02d:%02d" % [horas, mins] )
  end

  def horas_servicio_horas
    self.horas_servicio.split(":").first.to_i
  end

  def horas_servicio_mins
    self.horas_servicio.split(":").last.to_i
  end

  def porcentaje_horas_servicio
    self.horas_servicio_horas * 10.0/48.0
  end

  private
    def delete_prestador_relation
      Prestador.update(self.prestador.id, inscripcion_actual: nil)
    end

end
