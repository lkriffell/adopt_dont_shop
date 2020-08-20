require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters edit page' do
  before :each do
  end

  it 'displays edit shelter form' do
    @shelter1 = Shelter.create(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213")
    visit "/shelters/#{@shelter1.id}/edit"

    expect(page).to have_content("name")
    expect(page).to have_content("address")
    expect(page).to have_content("city")
    expect(page).to have_content("state")
    expect(page).to have_content("zip")

  end
end
