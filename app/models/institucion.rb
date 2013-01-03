# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: institucions
#
#  id         :integer          not null, primary key
#  nombre     :string(255)      not null
#  educativa  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uacm       :boolean
#

class Institucion < ActiveRecord::Base
  attr_accessible :educativa, :nombre, :plantels_attributes
  validates :nombre, presence: true, uniqueness: true

  has_many :plantels, dependent: :destroy
  has_many :institucion_users
  accepts_nested_attributes_for :plantels

  def find_uacm
  	Institucion.where(uacm: true).first
  end
end
