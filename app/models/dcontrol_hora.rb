# == Schema Information
#
# Table name: dcontrol_horas
#
#  id              :integer          not null, primary key
#  control_hora_id :integer
#  fecha           :date
#  Hora_Entrada    :time
#  Hora_Salida     :time
#  Horas_Dia       :time
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class DcontrolHora < ActiveRecord::Base
  attr_accessible :Hora_Entrada, :Hora_Salida, :Horas_Dia, :fecha
end
