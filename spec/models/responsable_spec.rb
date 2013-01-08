# == Schema Information
#
# Table name: responsables
#
#  id           :integer          not null, primary key
#  cprograma_id :integer
#  encargado    :string(255)
#  cargo        :string(255)
#  email        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Responsable do
  pending "add some examples to (or delete) #{__FILE__}"
end
