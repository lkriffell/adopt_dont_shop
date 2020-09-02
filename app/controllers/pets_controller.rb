class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    @shelter = Shelter.find(@pet.shelter_id)
    @apps_pets = ApplicationsPets.where(pets_id: params[:id])
    if @apps_pets != []
      @app = Application.get_app_by_id(@apps_pets.first.applications_id)
    end
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def flash_helper
    string = ""
    params.each do |param, value|
      if value == "" && string == ""
        string = "You must fill in #{param}"
      elsif value == ""
        string += " and #{param}"
      end
    end
    string
  end

  def create
    @pet = Pet.new(pet_params)

    @pet.save
    flash[:alert] = flash_helper
    if flash[:alert] == ""
      redirect_to "/shelters/#{params[:shelter_id]}/pets"
    else
      redirect_to "/shelters/#{params[:shelter_id]}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    @shelter = Shelter.find(@pet.shelter_id)
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    @pet.save
    flash[:alert] = flash_helper
    if flash[:alert] == ""
      redirect_to "/pets/#{@pet.id}"
    else
      redirect_to "/pets/#{@pet.id}/edit"
    end
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def add_favorite
    @pet = Pet.find(params[:id])
    @pet.set_favorite_true
    flash[:notice] = "#{@pet.name} has been added to your favorites list"

    redirect_to "/pets/#{@pet.id}"
  end

  def show_favorite
    @favorites = Pet.favorited_pets
    @app_pets = ApplicationsPets.all
    @ids = @app_pets.map do |pet|
      pet.pets_id
    end.uniq
  end

  def remove_favorite_from_pets_show
    @pet = Pet.find(params[:id])
    @pet.set_favorite_true
    flash[:notice] = "#{@pet.name} has been removed from your favorites list"
    redirect_to "/pets/#{@pet.id}"
  end

  def remove_favorite_from_favorites
    @pet = Pet.find(params[:id])
    @pet.set_favorite_false
    flash[:notice] = "#{@pet.name} has been removed from your favorites list"
    redirect_to "/favorites"
  end

  def remove_all_favorites
    @favorites = Pet.favorited_pets
    @favorites.each do |favorite|
      favorite.set_favorite_false
    end
    redirect_to "/favorites"
  end

  private
  def pet_params
    params.permit(:name, :approximate_age, :sex, :adoption_status, :current_location, :shelter_id, :image)
  end
end
