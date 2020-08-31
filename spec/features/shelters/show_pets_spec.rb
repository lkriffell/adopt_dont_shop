require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213",
                                id: "1")
    @pet1 = Pet.create!(name: "Jimbo",
                        approximate_age: "1",
                        sex: "male",
                        image: "jimbo.jpg",
                        adoption_status: "Adoptable",
                        current_location: "Alfredo's Adoption",
                        shelter_id: "1")
  end

  it 'displays pet attributes' do
    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_content("Up For Adoption At")
    expect(page).to have_content(@shelter1.pets.count)
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    expect(page).to have_link("Update Pet", href: "/pets/#{@pet1.id}/edit")
    expect(page).to have_link("Delete Pet", href: "/pets/#{@pet1.id}")


  end
end
