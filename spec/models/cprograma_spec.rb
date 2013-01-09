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

require 'spec_helper'

describe Cprograma do
  
end
