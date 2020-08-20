require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters new page' do
  before :each do
  end

  it 'displays new shelter form' do
    visit '/shelters/new'

    expect(page).to have_content("name")
    expect(page).to have_content("address")
    expect(page).to have_content("city")
    expect(page).to have_content("state")
    expect(page).to have_content("zip")

  end
end
