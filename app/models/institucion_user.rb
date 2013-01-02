# == Schema Information
#
# Table name: institucion_users
#
#  id             :integer          not null, primary key
#  institucion_id :integer          not null
#  plantel_id     :integer          not null
#  domicilio      :string(255)      not null
#  area           :string(255)      not null
#  responsable    :string(255)      not null
#  cargo          :string(255)      not null
#  tel            :string(255)      not null
#  telExt         :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class InstitucionUser < ActiveRecord::Base
  attr_accessible :area, :cargo, :domicilio, :institucion_id, :plantel_id, :responsable, :tel, :telExt, :user_attributes
  
  validates_presence_of :area, :cargo, :domicilio, :responsable, :tel, :telExt, :institucion_id, :plantel_id, :user

	# Relaciones
  has_one :user
  accepts_nested_attributes_for :user
  # has_one :plantel
  # has_one :institucion
end
