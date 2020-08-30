class ApplicationsController < ApplicationController

  def apply
    @favorites = Pet.favorited_pets
  end

  def show
    @app = Application.find(params[:id])
    @apps_pets = ApplicationsPets.where(applications_id: params[:id])
  end

  def submit
    @favorites = Pet.favorited_pets
    ids = @favorites.select(:id)
    @pets_applied_for = ""
    checked_pets = []
    ids.each do |id|
      if params.include?(id.id.to_s)
        checked_pets << id
      end
    end
    if @favorites == []
      flash[:alert] = "You have no current favorites to apply for!"
      redirect_to '/favorites'
    elsif params.value?("")
      flash[:alert] = "You must complete the form in order to submit the application"
      redirect_to '/favorites/apply'
    elsif checked_pets != []
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
      new_app = Application.create!(application_params)
      checked_pets.each do |checked_pet|
        ApplicationsPets.create!({applications_id: new_app.id, pets_id: checked_pet.id})
      end
      flash[:notice] = "Your application for #{@pets_applied_for} has been submitted!"
      redirect_to '/favorites'
    else
      flash[:alert] = "You must select a pet to apply for."
      redirect_to '/favorites/apply'
    end
  end

  def collect_checked_pets
    ids = Pet.all.select(:id)
    checked_pets = []
    ids.each do |id|
      if params.include?(id.id.to_s)
        checked_pets << id
      end
    end
    checked_pets
  end

  def approve
    app = Application.find(params[:id])
    checked_pets = collect_checked_pets
    checked_pets.each do |checked_pet|
      pet = Pet.find(checked_pet.id)
      pet.update!(adoption_status: "Pending")
      pet.save!
      #require "pry"; binding.pry
    end
    flash[:notice] = "Thank You. Your application is pending."
    redirect_to "/applications/#{app.id}"
  end

  def revoke
    pet = Pet.get_pet_by_id(params[:pet_id])
    pet.update!(adoption_status: "Adoptable")
    pet.save!
    flash[:notice] = "#{pet.name} has been revoked from your application."
    redirect_to "/applications/#{params[:id]}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
