require 'spec_helper'
require 'rails_helper'
RSpec.describe 'new pet' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption", address: "55555",
      city: "Denver", state: "CO", zip: "34213")
  end

  it 'displays new pet form and creates a pet' do
    visit "/shelters/#{@shelter1.id}/pets/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate Age")
    expect(page).to have_content("Sex")
    expect(page).to have_content("Image")
    expect(page).to have_content("Status")
    expect(page).to have_content("Location")

    fill_in :'pet[name]', with: "Jimbo"
    fill_in :'pet[approximate_age]', with: 2
    fill_in :'pet[sex]', with: "male"
    fill_in :'pet[image]', with: "jimbo.jpg"

    click_on "Create Pet"

    #Test pet was created
    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    expect(page).to have_content("Jimbo")
    expect(page).to have_content(2)
    expect(page).to have_content("male")
    expect(page).to have_xpath("//img['jimbo.jpg']")

    Pet.all.includes(Pet.last)

    #Test pet can be deleted
    click_on "Delete Pet"
    !Pet.all.includes(Pet.last)
  end
end
