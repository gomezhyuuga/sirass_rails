# encoding: UTF-8
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

require 'spec_helper'
require 'pp'

describe Prestador do

  subject { @prestador }

  before do
    @prestador = buildModel(:prestador)
    # @prestador_user = buildModel(:user)
    @prestador_user = buildModel(:user)
    @prestador.user = @prestador_user
  end
  
  # Presencia de atributos
  it { should respond_to(:nombre) }
  it { should respond_to(:aPaterno) }
  it { should respond_to(:aMaterno) }
  it { should respond_to(:nacimiento) }
  it { should respond_to(:sexo) }
  it { should respond_to(:dCalle) }
  it { should respond_to(:dNumExt) }
  it { should respond_to(:dNumInt) }
  it { should respond_to(:dCP) }
  it { should respond_to(:dDelegacion) }
  it { should respond_to(:dColonia) }
  it { should respond_to(:telCasa) }
  it { should respond_to(:telCel) }
  
  it { should be_valid }


  it "has a valid factory" do
    @prestador.should be_valid
  end

  it "should be invalid if doesn't have nombre" do
    @prestador.nombre = nil
    @prestador.should_not be_valid
  end

  it "should be invalid if its user is invalid" do
    @prestador.user.username = nil
    @prestador.user.should_not be_valid
    @prestador.should_not be_valid
  end

  it "should be saved with his user" do
    @prestador.save!
    @prestador.id.should_not be_nil
    @prestador.user.id.should_not be_nil
  end

  it "should not have an id if is not saved" do
    @prestador.id.should be nil
    @prestador.user.id.should be nil
  end
end
