require 'rails_helper'

describe Pet, type: :model do
  before :each do

  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :approximate_age }
    it { should validate_presence_of :adoption_status }
    it { should validate_presence_of :current_location }
    it { should validate_presence_of :shelter_id }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

end
