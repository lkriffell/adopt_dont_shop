require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters index page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
  end

  it 'shelter name displays' do
    visit '/shelters'

    expect(page).to have_content("All Shelters")
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content("Update Shelter")
    expect(page).to have_content("Delete Shelter")
  end
end
