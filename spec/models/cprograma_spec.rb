# == Schema Information
#
# Table name: cprogramas
#
#  id             :integer          not null, primary key
#  institucion_id :integer
#  cveprograma    :string(255)
#  categoria_id   :integer
#  status_id      :integer
#  nombre         :string(255)
#  objGeneral     :text
#  justificacion  :text
#  desarrollo     :text
#  recursos       :text
#  evaluacion     :text
#  resultados     :text
#  lugar          :string(255)
#  horario_id     :integer
#  plazas         :integer
#  vacantes       :integer
#  observaciones  :text
#  notas          :text
#  tiempo_id      :integer
#  ftiempo        :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Cprograma do
  pending "add some examples to (or delete) #{__FILE__}"
end
