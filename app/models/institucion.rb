# == Schema Information
#
# Table name: institucions
#
#  id         :integer          not null, primary key
#  nombre     :string(255)      not null
#  educativa  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uacm       :boolean          default(FALSE)
#

# -*- encoding : utf-8 -*-
class Institucion < ActiveRecord::Base
  attr_accessible :educativa, :nombre, :plantels_attributes
  validates :nombre, presence: true, uniqueness: true

  has_many :plantels, dependent: :destroy
  has_many :institucion_users, dependent: :destroy
  has_many :inscripcions, dependent: :destroy
  accepts_nested_attributes_for :plantels

  def find_uacm
  	Institucion.where(uacm: true).first
  end
end
