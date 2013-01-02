# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  username                     :string(255)      not null
#  email                        :string(255)
#  crypted_password             :string(255)
#  salt                         :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  prestador_id                 :integer
#  admin_id                     :integer
#  institucion_user_id          :integer
#

require 'spec_helper'
require 'pp'

describe User do
  before do
    # @user = User.new( username: 'foobar',
    #                   email: 'foobar@me.com',
    #                   password: 'foobar',
    #                   password_confirmation: 'foobar')
    @user = buildModel(:user)
    # @user = buildModel(:user)
  end

  subject { @user }

  it "has a valid factory" do
    @user.should be_valid
  end

  it { should respond_to(:username) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:prestador) }

  it { should be_valid }

  describe "validation of attributes" do
  	describe "when username is not present" do
  		before { @user.username = "" }
  		it { should_not be_valid }
  	end

  	describe "when password is not present" do
  		before { @user.password = "" }
  		it { should_not be_valid }
  	end

  	describe "when password is nil" do
  		before { @user.password = nil }
  		it { should_not be_valid }
  	end

  	describe "when password_confirmation doesn't match" do
  		before { @user.password_confirmation = "missmatch" }
  		it { should_not be_valid }
  	end
  end

  describe "user page" do
    describe "of prestador" do
      prestador = buildModel(:prestador)
      prestador.user = buildModel(:user)
      prestador.save!

      prestador.user.user_page.should == '/prestador/home'
    end
    describe "of institucion" do
      institucion = buildModel(:institucion_user)
      institucion.user = buildModel(:user)
      institucion.save!

      institucion.user.user_page.should == '/institucion/home'
    end
    describe "of admin" do
      admin = buildModel(:admin)
      admin.user = buildModel(:user)
      admin.save!

      admin.user.user_page.should == '/admin/home'
    end
  end
end