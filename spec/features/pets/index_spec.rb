require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'pets index' do
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
    @pet2 = Pet.create!(name: "Elmer",
                        approximate_age: "5",
                        sex: "male",
                        image: "elmer.jpg",
                        adoption_status: "Pending",
                        current_location: "Alfredo's Adoption",
                        shelter_id: "1")
    @app1 = Application.create!(name: "John",
                                address: 21345,
                                city:"Denver",
                                zip: 80025,
                                state: "CO",
                                phone_number: "234-735-4743",
                                description: "I'm the best.")
    @app_pets = ApplicationsPets.create!(applications_id: @app1.id, pets_id: @pet1.id)
    @app_pets2 = ApplicationsPets.create!(applications_id: @app1.id, pets_id: @pet2.id)
  end

  it 'displays pet attributes' do
    visit "/pets"

    expect(page).to have_content("All Pets")
    expect(page).to have_content(@pet1.name)
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.current_location)
    expect(page).to have_link("#{@pet1.current_location}", href: "/shelters/#{@shelter1.id}")
    expect(page).to have_xpath("//img['jimbo.jpg']")
    expect(page).to have_link("Update Pet", href: "/pets/#{@pet1.id}/edit")
    expect(page).to have_link("Delete Pet", href: "/pets/#{@pet1.id}")

  end

  it 'removes delete pet button when application status is pending.' do
    @pet1.update(adoption_status: "Pending")
    @pet1.save!
    visit "/pets/#{@pet1.id}"
    expect(page).to_not have_link("Delete Pet")
  end
end
