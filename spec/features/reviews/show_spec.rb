require 'spec_helper'
require 'rails_helper'
RSpec.describe 'Review show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
  end

    it 'can list reviews' do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_link('Add Review')
    end
end
