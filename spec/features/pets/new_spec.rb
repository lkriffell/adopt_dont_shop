require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'new pet' do
  before :each do
  end

  it 'displays new pet form' do
    @shelter1 = Shelter.create(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213")
    visit "/shelters/#{@shelter1.id}/pets/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate Age")
    expect(page).to have_content("Sex")
    expect(page).to have_content("Image")
    expect(page).to have_content("Status")
    expect(page).to have_content("Location")
    expect(page).to have_content("Shelter ID")

  end
end
