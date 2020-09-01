require 'rails_helper'

describe Shelter do
  before :each do

  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'pets pending' do
    it 'should list pets with pending status' do
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
                          adoption_status: "Pending",
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

      expect(@shelter1.pets_pending).to eq([@pet2])
    end
  end

  describe 'delete pets' do
    it 'deletes the shelters pets' do
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
                          adoption_status: "Pending",
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
      #require "pry"; binding.pry

      @shelter1.delete_shelter_references(@shelter1.id)

      expect(Shelter.find("#{@shelter1.id}").pets).to eq([])
    end
  end

end
