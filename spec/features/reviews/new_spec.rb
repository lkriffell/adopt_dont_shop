require 'spec_helper'
require 'rails_helper'
RSpec.describe 'Review show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
  end

  it 'can create reviews' do

    visit "/shelters/#{@shelter1.id}/new"

    expect(page).to have_content('Title:')
    expect(page).to have_content('Rating (out of 5):')
    expect(page).to have_content('Content:')
    expect(page).to have_content('Image (optional):')


    fill_in :title, with: "Terrible Service"
    fill_in :rating, with: 1
    fill_in :content, with: "We did eight hours just to get my dog!! And when I got him he was covered in chocolate syrup :("

    click_on "Submit Review"

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content('Terrible Service')
  end

  it 'can display flash message' do

    visit "/shelters/#{@shelter1.id}/new"

    fill_in :title, with: "Terrible Service"
    fill_in :content, with: "We did eight hours just to get my dog!! And when I got him he was covered in chocolate syrup :("

    click_on "Submit Review"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/new")
    expect(page).to have_content("You need to fill in a title, rating, and content in order to submit a shelter review")
  end
end
