require 'spec_helper'
require 'rails_helper'
RSpec.describe 'pets edit page' do

  it 'displays edit pet form' do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213", id: "1")
    @pet1 = Pet.create!(name: "Jimbo", approximate_age: "1", sex: "male", image: "jimbo.jpg",
                      adoption_status: "Adoptable", current_location: "Alfredo's Adoption", shelter_id: "1", id: "1")

    visit "/pets/#{@pet1.id}/edit"

    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate Age")
    expect(page).to have_content("Sex")
    expect(page).to have_content("Image")
  end

  it 'can edit pet' do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213", id: "1")
    @pet1 = Pet.create!(name: "Larry", approximate_age: "10", sex: "female", image: "image.jpg",
                      adoption_status: "Adoptable", current_location: "Alfredo's Adoption", shelter_id: "1", id: "1")
    name = "Jimbo"
    approximate_age = 1
    sex = "male"
    image = "jimbo.jpg"

    visit "/pets/#{@pet1.id}/edit"
    fill_in :name, with: name
    fill_in :approximate_age, with: approximate_age
    fill_in :image, with: image
    fill_in :sex, with: sex

    click_on "Update Pet"

    # Test it saves updated info
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Jimbo")
    expect(page).to have_content(1)
    expect(page).to have_content("male")
    expect(page).to have_xpath("//img['jimbo.jpg']")

  end

  it 'displays flash message when field(s) are missing' do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213", id: "1")
    @pet1 = Pet.create!(name: "Larry", approximate_age: "10", sex: "female", image: "image.jpg",
                      adoption_status: "Adoptable", current_location: "Alfredo's Adoption", shelter_id: "1", id: "1")

    visit "/pets/#{@pet1.id}/edit"

    fill_in :name, with: "Jimbo"
    fill_in :approximate_age, with: 2
    fill_in :sex, with: ""
    fill_in :image, with: "jimbo.jpg"

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    expect(page).to have_content("You must fill in sex")
  end
end
