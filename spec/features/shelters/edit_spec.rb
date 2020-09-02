require 'spec_helper'
require 'rails_helper'

RSpec.describe 'shelters edit page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
  end

  it 'displays edit shelter form' do
    visit "/shelters/#{@shelter1.id}/edit"

    expect(page).to have_content("name")
    expect(page).to have_content("address")
    expect(page).to have_content("city")
    expect(page).to have_content("state")
    expect(page).to have_content("zip")


    fill_in :name, with: "bobby john's adoption"
    fill_in :address, with: "55837"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"

    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content("bobby john's adoption")
    expect(page).to have_content("55837")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
  end

end
