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

require 'spec_helper'

describe Programa do
  
end
