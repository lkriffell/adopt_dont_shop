class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def pets_pending
    pets.where("adoption_status = 'Pending'")
  end

  def delete_shelter_references(shelter_id)
    reviews = Review.where("shelter_id = #{shelter_id}")
    reviews.each do |review|
      review.destroy
    end
    pets.each do |pet|
      app_pets = ApplicationsPets.where("pets_id = #{pet.id}")
      app_pets.each do |app_pet|
        app_pet.destroy
      end
      pet.destroy
    end
  end

  def pet_count
    pets.count
  end

  def average_review(shelter_id)
    Review.where("shelter_id = #{shelter_id}").average(:rating)
  end

  def num_applications(shelter_id)
    pet_id = Pet.where("shelter_id = #{shelter_id}").pluck(:id)
    applications_array = []
    pet_count = pet_id.each do |id|
      applications_array << ApplicationsPets.where("pets_id = #{id}")
    end
    applications_array.flatten.count
  end
end
