require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters new page' do
  before :each do
    ApplicationsPets.delete_all
    Pet.delete_all
    Shelter.delete_all
  end

  it 'displays new shelter form' do
    visit '/shelters/new'

    expect(page).to have_content("name")
    expect(page).to have_content("address")
    expect(page).to have_content("city")
    expect(page).to have_content("state")
    expect(page).to have_content("zip")

    fill_in :'shelter[name]', with: "Alfredo's Adoption"
    fill_in :'shelter[address]', with: 55837
    fill_in :'shelter[city]', with: "Denver"
    fill_in :'shelter[state]', with: "CO"
    fill_in :'shelter[zip]', with: 34521


    click_on "Create Shelter"

    new_shelter = Shelter.last

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Alfredo's Adoption")
    expect(page).to have_link("#{new_shelter.name}", href: "/shelters/#{new_shelter.id}")
    expect(page).to have_link("Update Shelter", href: "/shelters/#{new_shelter.id}/edit")
    expect(page).to have_link("Delete Shelter", href: "/shelters/#{new_shelter.id}")


    Shelter.all.includes(new_shelter)

    click_on "Delete Shelter"
    !Shelter.all.includes(new_shelter)
  end
end
