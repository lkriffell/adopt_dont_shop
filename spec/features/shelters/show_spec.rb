require 'spec_helper'
require 'rails_helper'
RSpec.describe 'shelters show page' do
  before :each do
    ApplicationsPets.delete_all
    Pet.delete_all
    Shelter.delete_all

    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
    @pet1 = Pet.create!(name: "Jimbo",
                        approximate_age: "1",
                        sex: "male",
                        image: "jimbo.jpg",
                        adoption_status: "Adoptable",
                        current_location: "Alfredo's Adoption",
                        shelter_id: "#{@shelter1.id}")
    @pet2 = Pet.create!(name: "Elmer",
                        approximate_age: "5",
                        sex: "male",
                        image: "elmer.jpg",
                        adoption_status: "Adoptable",
                        current_location: "Alfredo's Adoption",
                        shelter_id: "#{@shelter1.id}")

    @app1 = Application.create!(name: "John",
                                address: 21345,
                                city:"Denver",
                                zip: 80025,
                                state: "CO",
                                phone_number: "234-735-4743",
                                description: "I'm the best.")
    @app_pets_1 = ApplicationsPets.create!(applications_id: @app1.id, pets_id: @pet1.id)
    @app_pets_2 = ApplicationsPets.create!(applications_id: @app1.id, pets_id: @pet2.id)
  end

  it 'shelter attributes displays' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.address)
    expect(page).to have_content(@shelter1.city)
    expect(page).to have_content(@shelter1.state)
    expect(page).to have_content(@shelter1.zip)
  end

  describe 'has no delete link' do
    it 'when any pets are pending' do
      visit "/applications/#{@app1.id}"

      within("#checked_field-#{@pet1.id}") do
        page.check "checked_pets[]"
      end

      within("#checked_field-#{@pet2.id}") do
        page.check "checked_pets[]"
      end


      click_on "Approve Application"

      visit "/shelters/#{@shelter1.id}"
      expect(page).to_not have_link("Delete Shelter")

    end
  end

  describe 'has a delete link' do
    it 'when no pets are pending' do
      visit "/shelters/#{@shelter1.id}"
      expect(page).to have_link("Delete Shelter")
    end
  end

  describe 'when a shelter is deleted' do
    it 'so are its pets' do
      visit "/shelters/#{@shelter1.id}"
      expect(page).to have_link("Delete Shelter")
      click_link "Delete Shelter"
      require "pry"; binding.pry

      expect(Pet.all).to eq(nil)
    end
  end
end
