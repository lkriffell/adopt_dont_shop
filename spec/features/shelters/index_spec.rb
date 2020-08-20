require 'spec_helper'
require 'rails_helper'
# Before each for setup
RSpec.describe 'shelters index page' do
  before :each do
  end

  it 'shelter name displays' do
    @shelter1 = Shelter.create(name: "Alfredo's Adoption", address: "55555",
      city: "Denver", state: "CO", zip: "34213")
    visit '/shelters'

    expect(page).to have_content(@shelter1.name)
  end
end
