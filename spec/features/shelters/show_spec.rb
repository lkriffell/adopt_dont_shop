require 'spec_helper'
require 'rails_helper'
RSpec.describe 'shelters show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
  end

  it 'shelter attributes displays' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.address)
    expect(page).to have_content(@shelter1.city)
    expect(page).to have_content(@shelter1.state)
    expect(page).to have_content(@shelter1.zip)
  end

  describe 'shelters show page' do
    it 'can list reviews' do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content('Title:')
      expect(page).to have_content('Rating:')
      expect(page).to have_content('Content:')
    end
  end
end
