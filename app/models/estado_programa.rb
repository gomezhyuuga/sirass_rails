# == Schema Information
#
# Table name: estado_programas
#
#  id          :integer          not null, primary key
#  descripcion :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EstadoPrograma < ActiveRecord::Base
  attr_accessible :descripcion
end
