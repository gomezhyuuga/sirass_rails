# == Schema Information
#
# Table name: licenciaturas
#
#  id           :integer          not null, primary key
#  cprograma_id :integer
#  carrera      :string(255)
#  actividad    :string(255)
#  solicitados  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Licenciatura do
  pending "add some examples to (or delete) #{__FILE__}"
end
