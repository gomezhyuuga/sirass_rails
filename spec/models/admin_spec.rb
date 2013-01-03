# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  nombre     :string(255)      not null
#  aPaterno   :string(255)      not null
#  aMaterno   :string(255)      not null
#  nacimiento :date             not null
#  cargo      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Admin do
end
