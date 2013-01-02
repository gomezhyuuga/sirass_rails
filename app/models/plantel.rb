# == Schema Information
#
# Table name: plantels
#
#  id             :integer          not null, primary key
#  institucion_id :integer          not null
#  nombre         :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Plantel < ActiveRecord::Base
  attr_accessible :institucion_id, :nombre

  validates_presence_of :institucion, :nombre

  belongs_to :institucion
end
