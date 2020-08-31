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
    @pets_applied_for = ""
    if  @favorites == []
      flash[:alert] = "You have no current favorites to apply for!"
      redirect_to '/favorites'
    elsif params.value?("")
      flash[:alert] = "You must complete the form in order to submit the application"
      redirect_to '/favorites/apply'
    elsif params[:checked_pets] != nil
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
      new_app = Application.create!(application_params)
      params[:checked_pets].each do |pet_id|
        ApplicationsPets.create!({applications_id: new_app.id, pets_id: pet_id})
      end
      flash[:notice] = "Your application for #{@pets_applied_for} has been submitted!"
      redirect_to '/favorites'
    else
      flash[:alert] = "You must select a pet to apply for."
      redirect_to '/favorites/apply'
    end
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
