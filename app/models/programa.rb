# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: programas
#
#  id              :integer          not null, primary key
#  cvePrograma     :string(255)
#  nombre          :string(255)
#  objetivoGeneral :text
#  justificacion   :text
#  desarrollo      :text
#  recursos        :text
#  evaluacion      :text
#  resultados      :text
#  lugar           :string(255)
#  plazas          :integer
#  ocupadas        :integer
#  observaciones   :text
#  notas           :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Programa < ActiveRecord::Base
  attr_accessible :cvePrograma, :desarrollo, :evaluacion, :justificacion, :lugar, :nombre, :notas, :objetivoGeneral, :observaciones, :ocupadas, :plazas, :recursos, :resultados
end
