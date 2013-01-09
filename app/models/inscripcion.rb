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
#  difundir                   :boolean
#  responsable                :string(255)
#  cargoResponsable           :string(255)
#  observaciones              :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Inscripcion < ActiveRecord::Base
  attr_accessible :ano_ingreso, :area, :avance_cursos, :cargoResponsable, :carrera, :cprograma_id, :creditos, :cve_programa_institucional, :difundir, :estado_inscripcion_id, :fecha_fin, :fecha_inicio, :hora_entrada, :hora_salida, :institucion_id, :matricula, :nCursos_basicos, :nCursos_superio, :observaciones, :plantel_id, :practicas, :prestador_id, :programa_institucional, :promedio, :responsable, :semestre

  belongs_to :prestador
end
