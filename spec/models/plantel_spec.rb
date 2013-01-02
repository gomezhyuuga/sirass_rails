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

require 'spec_helper'

describe Plantel do
	before do
	  @plantel = buildModel(:plantel)
	end
	subject { @plantel }

	it { should respond_to(:nombre) }
	it { should respond_to(:institucion) }

	it "should not be valid if has not a institucion" do
		@plantel.institucion = nil
		@plantel.should_not be_valid
	end
end
