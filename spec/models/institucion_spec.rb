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

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Institucion do
	before do
	  @institucion = buildModel(:institucion)
	end
	subject { @institucion }

	it { should respond_to(:nombre) }
	it { should respond_to(:educativa) }
	it { should respond_to(:uacm) }

	it { should be_valid }

	# Asociaciones
	it { should respond_to(:plantels) }

	it "should be invalid if not has nombre" do
		@institucion.nombre = nil
		@institucion.should_not be_valid
	end

	describe "saving" do
		before do
		  @institucion.save!
			@institucion.plantels.create(nombre: 'Mi plantel')
			@institucion.plantels.create(nombre: 'Mi plantel2')
		end
		
		its(:id) { should_not be_nil }

		it "should should be saved with its plantel" do
			plantel = Plantel.find_by_nombre("Mi plantel")
			plantel.should_not be_nil
			plantel.institucion.should == @institucion
		end

		describe "and then destroying" do
			before { @institucion.destroy }

			it "should not has any plantel saved" do
				Plantel.find_by_nombre('Mi plantel').should be_nil
				Plantel.find_by_nombre('Mi plantel2').should be_nil
			end
		end
	end
end
