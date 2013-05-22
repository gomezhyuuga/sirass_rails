# == Schema Information
#
# Table name: prestadors
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)      not null
#  apaterno           :string(255)      not null
#  amaterno           :string(255)      not null
#  nacimiento         :date             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  sexo               :string(255)
#  dCalle             :string(255)
#  dNumExt            :string(255)
#  dNumInt            :string(255)
#  dCP                :string(255)
#  dDelegacion        :string(255)
#  dColonia           :string(255)
#  telCasa            :string(255)
#  telCel             :string(255)
#  estudiante_uacm    :boolean
#  inscripcion_actual :integer
#

# -*- encoding : utf-8 -*-
class Prestador < ActiveRecord::Base
  attr_accessible :amaterno, :apaterno, :nacimiento, :nombre, :user_attributes,
  	:sexo, :dCalle, :dNumExt, :dNumInt, :dCP, :dDelegacion, :dColonia, :telCasa, :telCel,
  	:inscripcion_actual, :estudiante_uacm
  	
  validates_presence_of :nombre, :amaterno, :apaterno, :nacimiento, :user,
  	:sexo, :dCalle, :dNumExt, :dCP, :dDelegacion, :dColonia
  
  # Relaciones
  has_one :user, dependent: :destroy
	accepts_nested_attributes_for :user

	has_many :inscripcions, dependent: :destroy

  
  def nombre_completo
    "#{self.nombre} #{self.apaterno} #{self.amaterno}"
  end
end
