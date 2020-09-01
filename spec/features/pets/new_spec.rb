require 'spec_helper'
require 'rails_helper'
RSpec.describe 'new pet' do
  before :each do
    ApplicationsPets.delete_all
    Application.delete_all
    Pet.delete_all
    Shelter.delete_all

    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213"
                              )
  end

  it 'displays new pet form and creates a pet' do
    visit "/shelters/#{@shelter1.id}/pets/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate Age")
    expect(page).to have_content("Sex")
    expect(page).to have_content("Image")

    fill_in :name, with: "Jimbo"
    fill_in :approximate_age, with: 2
    fill_in :sex, with: "male"
    fill_in :image, with: "jimbo.jpg"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    expect(page).to have_content("Jimbo")
    expect(page).to have_content(2)
    expect(page).to have_content("male")
    expect(page).to have_xpath("//img['jimbo.jpg']")

    Pet.all.includes(Pet.last)

    click_on "Delete Pet"
    !Pet.all.includes(Pet.last)
  end

  it 'displays flash message when field(s) are missing' do
    visit "/shelters/#{@shelter1.id}/pets/new"

    fill_in :name, with: "Jimbo"
    fill_in :approximate_age, with: ""
    fill_in :sex, with: ""
    fill_in :image, with: "jimbo.jpg"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")
    expect(page).to have_content("You must fill in approximate_age and sex")
  end
end
