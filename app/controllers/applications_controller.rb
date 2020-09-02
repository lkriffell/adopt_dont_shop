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
    if  @favorites == []
      flash[:alert] = "You have no current favorites to apply for!"
      redirect_to '/favorites'
    elsif params.value?("")
      flash[:alert] = "You must complete the form in order to submit the application"
      redirect_to '/favorites/apply'
    elsif params[:checked_pets] != nil
      @pets_applied_for = check_params_for_empties
      create_app_and_app_pets
      flash[:notice] = "Your application for #{@pets_applied_for} has been submitted!"
      redirect_to '/favorites'
    else
      flash[:alert] = "You must select a pet to apply for."
      redirect_to '/favorites/apply'
    end
  end

  def create_app_and_app_pets
    new_app = Application.create!(application_params)
    params[:checked_pets].each do |pet_id|
      ApplicationsPets.create!({applications_id: new_app.id, pets_id: pet_id})
    end
  end

  def check_params_for_empties
    @pets_applied_for = ""
    params[:checked_pets].each do |pet_id|
      pet = Pet.get_pet_by_id(pet_id)
      pet[:favorite] = false
      pet.save!
      if @pets_applied_for == ""
        @pets_applied_for += pet.name
      else
        @pets_applied_for += " and #{pet.name}"
      end
    end
    @pets_applied_for
  end

  def approve
    app = Application.find(params[:id])
    params[:checked_pets].each do |pet_id|
      pet = Pet.get_pet_by_id(pet_id)
      pet.update!(adoption_status: "Pending")
      pet.save!
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
