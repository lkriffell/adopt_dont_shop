class ApplicationsController < ApplicationController
  def apply
    @favorites = Pet.favorited_pets
  end

  def submit
    @favorites = Pet.favorited_pets
    pets_applied_for = ""
    @favorites.each do |favorite|
      if params.include?(favorite.id.to_s)
        favorite[:favorite] = false
        favorite.save!
        if pets_applied_for == ""
          pets_applied_for += favorite.name
        else
          pets_applied_for += " and #{favorite.name}"
        end
      end
    end
    flash[:notice] = "Your application for #{pets_applied_for} has been submitted!"
    redirect_to '/favorites'
  end
end
