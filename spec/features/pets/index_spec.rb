require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'pets index' do
  before :each do
  end

  it 'displays pet attributes' do
    @shelter1 = Shelter.create(name: "Alfredo's Adoption", address: "55555",
                              city: "Denver", state: "CO", zip: "34213", id: "1")
    @pet1 = Pet.create(name: "Jimbo", approximate_age: "1", sex: "male", image: "lab_puppy_dog_pictures.jpg",
      adoption_status: "Adoptable", current_location: "Alfredo's Adoption", shelter_id: "1")
    visit "/pets"

    expect(page).to have_content("All Pets")
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_css("img[src*='lab_puppy_dog_pictures.jpg']")
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.current_location)
  end
end
