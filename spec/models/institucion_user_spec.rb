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

require 'spec_helper'

describe InstitucionUser do

	before do
		@i_user = buildModel(:institucion_user)
		# @user = buildModel(:user)
		@user = buildModel(:user)
		@i_user.user = @user
		@i_user.institucion = Institucion.find_or_create_by_nombre("Mi institucion")
	end

	subject { @i_user }

	# Presencia de atributos
	it { should respond_to(:institucion_id) }
	it { should respond_to(:plantel_id) }
	it { should respond_to(:domicilio) }
	it { should respond_to(:area) }
	it { should respond_to(:responsable) }
	it { should respond_to(:cargo) }
	it { should respond_to(:tel) }
	it { should respond_to(:telExt) }
	it { should_not respond_to(:notPresent) }

	# Validaciones
	describe "validations" do
		it { should be_valid }
		its(:user) { should_not be nil }

		describe "when hasn't an user" do
			before { @i_user.user = nil }
			it { should be_invalid }
		end

		describe "when its user is invalid" do
			before { @i_user.user.username = nil }
			its(:user) { should be_invalid }
			it { should_not be_valid }
		end

		describe "when institucion is not present" do
			before { @i_user.institucion = nil }
			it { should_not be_valid }
		end
	end

	describe "saving" do
		describe "with an existent institucion and plantel" do
			before do
				institucion = Institucion.find_or_create_by_nombre('Institucion existente')
				plantel = Plantel.new(nombre: 'Plantel existente')
				plantel.institucion = institucion
				plantel.save!
				@i_user.institucion = institucion
				@i_user.plantel = plantel
			end

			it "should not change Institucion count" do
				lambda {
					@i_user.save!
				}.should_not change(Institucion, :count)
			end

			it "should not change Plantel count" do
				lambda { 
					@i_user.save!
				}.should_not change(Plantel, :count)
			end
		end

		describe "as a valid model" do
			before { @i_user.save! }
			it "should be saved with his user" do
				@i_user.id.should_not be nil
				@i_user.user.id.should_not be nil
				@i_user.institucion.id.should_not be nil
			end

			it "should have the correct user" do
				@i_user.user.should eq(@user)
				@user.institucion_user.should eq(@i_user)
			end
		end
	end
end
