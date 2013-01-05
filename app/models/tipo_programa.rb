# == Schema Information
#
# Table name: tipo_programas
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TipoPrograma < ActiveRecord::Base
  attr_accessible :descripcion
  has_many :cprograma
end
