# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: institucion_users
#
#  id             :integer          not null, primary key
#  institucion_id :integer          not null
#  plantel_id     :integer
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
  attr_accessible :area, :cargo, :domicilio, :responsable, :tel, :telExt, :user_attributes, :plantel_attributes, :institucion_attributes, :institucion_id, :plantel_id
  
  validates_presence_of :area, :cargo, :domicilio, :responsable, :tel, :telExt, :institucion_id, :user

	# Relaciones
  has_one :user
  belongs_to :plantel
  belongs_to :institucion
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :institucion
  accepts_nested_attributes_for :plantel
  has_many :cprogramas
end
