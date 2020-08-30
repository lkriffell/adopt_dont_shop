require 'rails_helper'

describe Application do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :description }
  end

  describe 'get app by id' do
    it 'gets an app by its id' do
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
      @app1 = Application.create!(name: "John",
                                  address: 21345,
                                  city:"Denver",
                                  zip: 80025,
                                  state: "CO",
                                  phone_number: "234-735-4743",
                                  description: "I'm the best.")

      found_app = Application.get_app_by_id(@app1.id)

      expect(found_app).to eq(@app1)
    end
  end

end
