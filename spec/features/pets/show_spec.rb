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

    expect(page).to have_content("Favorite This Pet")
    click_link 'Favorite This Pet'

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("#{@pet1.name} has been added to your favorites list")
  end

  it 'has a remove favorite button' do
    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'

    expect(page).to have_content("Remove From Favorites")
    click_link 'Remove From Favorites'

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("#{@pet1.name} has been removed from your favorites list")
  end

  it 'has a favorites page' do
    visit "/favorites"

    expect(page).to have_content("Favorite Pets")
  end

  it 'has a favorite link next to each pet on favorites page' do
    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'

    visit "/pets/#{@pet2.id}"
    click_link 'Favorite This Pet'

    visit "/favorites"

    within(".showpet-#{@pet1.id}") do
      expect(page).to have_link('Remove From Favorites')
    end
    within(".showpet-#{@pet2.id}") do
      expect(page).to have_link('Remove From Favorites')
    end
  end

  it 'can remove favorite pet from favorites page' do
    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'
    visit '/favorites'

    click_link "Remove From Favorites"
    expect(page).to_not have_content("#{@pet1.approximate_age}")
    expect(page).to_not have_link('Remove From Favorites')
  end

  it 'can let us know when we have no favorited pets' do
    visit '/favorites'
    expect(page).to have_content("You have no favorited pets")
  end

  it 'can removed all favorited pets' do
    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet2.id}"
    click_link 'Favorite This Pet'
    visit "/favorites"
    click_link 'Remove All Pets From Favorites'
    expect(page).to have_content("You have no favorited pets")
    expect(page).to_not have_content("#{@pet1.approximate_age}")
    expect(page).to_not have_content("#{@pet2.approximate_age}")

  end

  it 'can list pets who have been applied for' do
    visit "/pets/#{@pet1.id}"
    click_link 'Favorite This Pet'
    visit "/pets/#{@pet2.id}"
    click_link 'Favorite This Pet'

    visit "/favorites"

    click_link "Apply to Adopt"
    expect(current_path).to eq("/favorites/apply")

    within("#checked_field-#{@pet1.id}") do
      page.check "checked_pets[]"
    end

    fill_in :name, with: "John"
    fill_in :address, with: 21345
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80025
    fill_in :phone_number, with: "234-735-4743"
    fill_in :description, with: "I'm the best."

    click_on 'Submit Application'

    visit '/favorites'

    expect(page).to have_content("Pets with applications")
    expect(page).to have_content("#{@pet1.name}")
  end

  it 'shows link to all applications for the pet' do
    visit "/pets/#{@pet1.id}"
    expect(page).to have_content("Applications for Jimbo")
  end

  it 'removes delete pet button when application status is pending.' do
    visit "/pets/#{@pet2.id}"
    expect(page).to_not have_link("Delete Pet")
  end

end
