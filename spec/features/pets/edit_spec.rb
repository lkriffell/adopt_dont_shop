require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'pets edit page' do
  before :each do
  end

  it 'displays edit pet form' do
    @shelter1 = Shelter.create(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213", id: "1")
    @pet1 = Pet.create(name: "Jimbo", approximate_age: "1", sex: "male", image: "lab_puppy_dog_pictures.jpg",
                      adoption_status: "Adoptable", current_location: "Alfredo's Adoption", shelter_id: "1", id: "1")
    visit "/pets/#{@pet1.id}/edit"

    expect(page).to have_content("Name")
    expect(page).to have_content("Approximate Age")
    expect(page).to have_content("Sex")
    expect(page).to have_content("Image")
    expect(page).to have_content("Pet ID")

  end
end
