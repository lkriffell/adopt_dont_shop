class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets


  validates_presence_of :name
  validates_presence_of :sex
  validates_presence_of :approximate_age
  validates_presence_of :image

  def self.favorited_pets
    self.where(favorite: true)
  end

  def self.favorited_pets_count
    self.where(favorite: true).count
  end

  def self.get_pet_by_id(id)
    find(id)
  end
end
