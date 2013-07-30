# encoding: UTF-8
# == Schema Information
#
# Table name: articulos
#
#  id                    :integer          not null, primary key
#  estado_inscripcion_id :integer
#  prestador_id          :integer
#  Dependencia           :string(700)
#  Area                  :string(700)
#  Puesto                :string(255)
#  Fecha_Ingreso         :date
#  Contratacion          :string(255)
#  Jefe_inmediato        :string(700)
#  Cargo                 :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  antiguedad            :string(255)
#  observaciones         :text
#

class Articulo < ActiveRecord::Base
  attr_accessible :Area, :Cargo, :Contratacion, :Dependencia, :Fecha_Ingreso, :Jefe_inmediato, :Puesto, :antiguedad, 
  :observaciones, :estado_inscripcion_id

  validates_presence_of :Area, :Cargo, :Contratacion, :Dependencia, :Fecha_Ingreso, :Jefe_inmediato, :Puesto, :antiguedad

  belongs_to :prestador
  belongs_to :estado_inscripcion
  after_destroy :delete_prestador_relation

  private
    def delete_prestador_relation
      Prestador.update(self.prestador.id, articulo_id: nil)
    end
  
end
