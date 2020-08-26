require 'rails_helper'

  RSpec.describe 'navlink' do
    it 'can visit favorites' do
      visit '/shelters'
      click_link "Favorites"

      expect(current_path).to eq('/favorites')
    end
  end
