# == Schema Information
#
# Table name: institucion_users
#
#  id             :integer          not null, primary key
#  institucion_id :integer          not null
#  plantel_id     :integer          not null
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
		@institucion_user = buildModel(:institucion_user)
		# @user = buildModel(:user)
		@user = buildModel(:user)
		@institucion_user.user = @user
	end

	subject { @institucion_user }

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
			before { @institucion_user.user = nil }
			it { should be_invalid }
		end

		describe "when its user is invalid" do
			before { @institucion_user.user.username = nil }
			its(:user) { should be_invalid }
			it { should_not be_valid }
		end

		describe "when institucion_id is not present" do
			before { @institucion_user.institucion_id = nil }
			it { should_not be_valid }
		end
		describe "when plantel_id is not present" do
			before { @institucion_user.plantel_id = nil }
			it { should_not be_valid }
		end
	end

	describe "saving" do
		before { @institucion_user.save! }
		it "should be saved with his user" do
			@institucion_user.id.should_not be nil
			@institucion_user.user.id.should_not be nil
		end

		it "should have the correct user" do
			@institucion_user.user.should eq(@user)
			@user.institucion_user.should eq(@institucion_user)
		end
	end
end
