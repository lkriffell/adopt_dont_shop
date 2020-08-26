class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :name
  validates_presence_of :sex
  validates_presence_of :approximate_age
  validates_presence_of :image
  # validates_presence_of :adoption_status
  # validates_presence_of :current_location
  # validates_presence_of :shelter_id

  def self.favorited_pets
    self.where(favorite: true)
  end

  def self.favorited_pets_count
    self.where(favorite: true).count 
  end
end
