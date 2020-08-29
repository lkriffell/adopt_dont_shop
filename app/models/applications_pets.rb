class ApplicationsPets < ApplicationRecord
  has_many :applications
  has_many :pets

  validates_presence_of :applications_id, :pets_id
end
