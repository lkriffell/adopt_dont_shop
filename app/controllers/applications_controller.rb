class ApplicationsController < ApplicationController

  def apply
    @favorites = Pet.favorited_pets
  end

  def submit
    @favorites = Pet.favorited_pets
    ids = @favorites.select(:id)
    @pets_applied_for = ""
    pet_checked = false
    ids.each do |id|
      if params.include?(id.id.to_s)
        pet_checked = true
      end
    end
    if @favorites == []
      flash[:alert] = "You have no current favorites to apply for!"
      redirect_to '/favorites'
    elsif params.value?("")
      flash[:alert] = "You must complete the form in order to submit the application"
      redirect_to '/favorites/apply'
    elsif pet_checked
      @favorites.each do |favorite|
        if params.include?(favorite.id.to_s)
          favorite[:favorite] = false
          favorite.save!
          if @pets_applied_for == ""
            @pets_applied_for += favorite.name
          else
            @pets_applied_for += " and #{favorite.name}"
          end
        end
      end
      flash[:notice] = "Your application for #{@pets_applied_for} has been submitted!"
      redirect_to '/favorites'
    else
      flash[:alert] = "You must select a pet to apply for."
      redirect_to '/favorites/apply'
    end
  end
end
