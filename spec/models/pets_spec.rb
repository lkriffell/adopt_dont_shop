require 'rails_helper'

describe Pet, type: :model do
  before :each do

  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :approximate_age }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

end
