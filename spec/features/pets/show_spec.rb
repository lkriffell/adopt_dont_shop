require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'pet show' do
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
    @favorites = [@pet1]
  end

  it 'displays pet attributes' do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.current_location)
    expect(page).to have_xpath("//img['jimbo.jpg']")
    expect(page).to have_link("#{@pet1.current_location}", href: "/shelters/#{@shelter1.id}")
    expect(page).to have_link("Update Pet", href: "/pets/#{@pet1.id}/edit")
    expect(page).to have_link("Delete Pet", href: "/pets/#{@pet1.id}")

  end

  it 'has a favorite button' do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Favorite Pet")
    click_link 'Favorite Pet'

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Pet has been added to your favorites list")
  end

  it 'has a favorites page' do
    visit "/favorites"

    expect(page).to have_content("Favorite Pets")
  end
end
