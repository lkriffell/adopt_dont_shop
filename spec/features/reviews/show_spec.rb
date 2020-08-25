require 'spec_helper'
require 'rails_helper'
RSpec.describe 'Review show page' do
  before :each do
    @shelter1 = Shelter.create!(name: "Alfredo's Adoption",
                                address: "55555",
                                city: "Denver",
                                state: "CO",
                                zip: "34213")
    @review = @shelter1.reviews.create!(title: "Terrible Service",
                                      rating: 1,
                                      content: "We did eight hours just to get my dog!! And when I got him he was covered in chocolate syrup :(")
  end

    it 'can list reviews' do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_link('Add Review')

      expect(page).to have_link('Edit Review')
      expect(page).to have_content('Title: ')
      expect(page).to have_content('Rating (out of 5): ')
      expect(page).to have_content('Content: ')

      click_link "Edit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/#{@review.id}/edit")

      fill_in :title, with: "Terrible Service"
      fill_in :content, with: "We did eight hours just to get my dog!! And when I g"
      fill_in :rating, with: ""

      click_on "Update Review"
      expect(page).to have_content("You need to fill in a title, rating, and content in order to update a shelter review")
      expect(current_path).to eq("/shelters/#{@shelter1.id}/#{@review.id}/edit")

      fill_in :title, with: "Terrible Service"
      fill_in :content, with: "We did eight hours just to get my dog!! And when I g"
      fill_in :rating, with: 5

      click_on "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")


    end
end
