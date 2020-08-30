class ApplicationsPetsController < ApplicationRecord

  def abcd
    @ap_pet = ApplicationPet.all
  end
end
