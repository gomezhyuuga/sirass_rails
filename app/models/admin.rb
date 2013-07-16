# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  nombre     :string(255)      not null
#  apaterno   :string(255)      not null
#  amaterno   :string(255)      not null
#  nacimiento :date             not null
#  cargo      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base
  attr_accessible :amaterno, :apaterno, :cargo, :nacimiento, :nombre, :user_attributes

  validates_presence_of :nombre, :amaterno, :apaterno, :nacimiento, :cargo, :user

  # Relaciones
  has_one :user, dependent: :destroy
	accepts_nested_attributes_for :user
end
