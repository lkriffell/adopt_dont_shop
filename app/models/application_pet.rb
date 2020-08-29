class ApplicationPet < ApplicationRecord
  has_many :applications
  has_many :pets

end
