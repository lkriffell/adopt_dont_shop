class ApplicationsController < ApplicationController

  def apply
    @favorites = Pet.favorited_pets
  end

  def submit
    @favorites = Pet.favorited_pets
    names = @favorites.select(:name)
    @pets_applied_for = ""
    if @favorites == []
      flash[:alert] = "You have no current favorites to apply for!"
      redirect_to '/favorites'
    elsif params.value?("")
      flash[:alert] = "You must complete the form in order to submit the application"
      redirect_to '/favorites/apply'
    elsif names.each { |name| params.include?(name) }
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
