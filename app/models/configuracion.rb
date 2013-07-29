# encoding: UTF-8
# == Schema Information
#
# Table name: configuracions
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  valor      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Configuracion < ActiveRecord::Base
  attr_accessible :nombre, :valor
  validates_uniqueness_of :nombre
end
