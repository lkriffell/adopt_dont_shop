require 'spec_helper'
require 'rails_helper'
RSpec.describe 'pet application' do
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
  end

  it 'favorites page has link to apply for pets' do

    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'

    visit "/pets/#{@pet2.id}"
    click_link 'Favorite This Pet'

    visit "/favorites"
    expect(page).to have_link("Apply to Adopt")

    click_link "Apply to Adopt"
    expect(current_path).to eq("/favorites/apply")

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)

    page.check "#{@pet1.id}"
    page.check "#{@pet2.id}"
    expect(page).to have_checked_field("#{@pet1.id}")

    expect(page).to have_content("Name:")
    expect(page).to have_content("Address:")
    expect(page).to have_content("City:")
    expect(page).to have_content("State:")
    expect(page).to have_content("Zip:")
    expect(page).to have_content("Phone Number:")

    fill_in :name, with: "John"
    fill_in :address, with: 21345
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80025
    fill_in :phone_number, with: "234-735-4743"
    fill_in :description, with: "I would love them so much and spoil them"

    click_on "Submit Application"
    expect(current_path).to eq('/favorites')
    expect(page).to have_content("Your application for #{@pet1.name} and #{@pet2.name} has been submitted!")
  end

  it 'displays flash message when user has not filled out all application fields' do

    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'

    visit "/favorites"

    click_link "Apply to Adopt"

    page.check "#{@pet1.id}"
    fill_in :name, with: "John"
    fill_in :address, with: 21345
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80025
    fill_in :phone_number, with: "234-735-4743"
    fill_in :description, with: ""

    click_on 'Submit Application'

    expect(current_path).to eq("/favorites/apply")
    expect(page).to have_content("You must complete the form in order to submit the application")
  end
  it 'displays flash message when no pet is checked' do

    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'

    visit "/favorites"

    click_link "Apply to Adopt"

    fill_in :name, with: "John"
    fill_in :address, with: 21345
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80025
    fill_in :phone_number, with: "234-735-4743"
    fill_in :description, with: "I'm the best."

    click_on 'Submit Application'

    expect(current_path).to eq("/favorites/apply")
    expect(page).to have_content("You must select a pet to apply for.")
  end

end
