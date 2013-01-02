# == Schema Information
#
# Table name: prestadors
#
#  id          :integer          not null, primary key
#  nombre      :string(255)      not null
#  aPaterno    :string(255)      not null
#  aMaterno    :string(255)      not null
#  nacimiento  :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sexo        :string(255)
#  dCalle      :string(255)
#  dNumExt     :string(255)
#  dNumInt     :string(255)
#  dCP         :string(255)
#  dDelegacion :string(255)
#  dColonia    :string(255)
#  telCasa     :string(255)
#  telCel      :string(255)
#

class Prestador < ActiveRecord::Base
  attr_accessible :aMaterno, :aPaterno, :nacimiento, :nombre, :user_attributes,
  	:sexo, :dCalle, :dNumExt, :dNumInt, :dCP, :dDelegacion, :dColonia, :telCasa, :telCel
  	
  validates_presence_of :nombre, :aMaterno, :aPaterno, :nacimiento, :user,
  	:sexo, :dCalle, :dNumExt, :dCP, :dDelegacion, :dColonia
  
  # Relaciones
  has_one :user, dependent: :destroy
	accepts_nested_attributes_for :user

end
