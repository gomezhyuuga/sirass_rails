class CDia < ActiveRecord::Base
  attr_accessible :descripcion

  has_and_belongs_to_many :inscripcions
end
