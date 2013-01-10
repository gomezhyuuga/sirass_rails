# == Schema Information
#
# Table name: dia
#
#  id         :integer          not null, primary key
#  dia_semana :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dia < ActiveRecord::Base
  attr_accessible :dia_semana

  has_and_belongs_to_many :cprogramas

end
