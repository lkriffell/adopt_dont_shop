require 'spec_helper'
require 'rails_helper'
RSpec.describe 'pet applications show page' do
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
                        adoption_status: "In A Loving Home",
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
  end

  it 'displays all application attributes' do

    visit "/applications/#{Application.all.first.id}"

    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.zip)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.phone_number)
    expect(page).to have_content(@app1.description)

    expect(page).to have_content(@pet1.name)

    expect(page).to have_link(@pet1.name)
    click_on "#{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  it 'displays message when no apps are present' do

    visit "/pets/#{@pet2.id}"

    # Not sure how to test this with a dropdown menu
    # expect(page).to have_content("There are no current applications for this pet.")
  end

  it 'has link to approve app' do
    visit "/applications/#{@app1.id}"
    expect(page).to have_link("Approve Application")

    click_on "Approve Application"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{@app1.name}")
  end
end
