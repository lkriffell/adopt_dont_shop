class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @pet = Pet.new({
      name: params[:pet][:name],
      approximate_age: params[:pet][:approximate_age],
      sex: params[:pet][:sex],
      adoption_status: params[:pet][:adoption_status],
      current_location: params[:pet][:current_location],
      shelter_id: params[:pet][:shelter_id],
      image: params[:pet][:image]
      })
    shelter_id = params[:pet][:shelter_id]
    @pet.save
    redirect_to "/shelters/#{shelter_id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
      @pet.update({
        name: params[:pet][:name],
        approximate_age: params[:pet][:approximate_age],
        sex: params[:pet][:sex],
        current_location: params[:pet][:current_location],
        image: params[:pet][:image]
      })
      @pet.save!
      redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def add_favorite
    @pet = Pet.find(params[:id])
    @pet[:favorite] = true
    flash[:notice] = "#{@pet.name} has been added to your favorites list"
    @pet.save!
    redirect_to "/pets/#{@pet.id}"
  end

  def show_favorite
    @favorites = Pet.favorited_pets
  end

  def remove_favorite_from_pets_show
    @pet = Pet.find(params[:id])
    @pet[:favorite] = false
    @pet.save!
    flash[:notice] = "#{@pet.name} has been removed from your favorites list"
    redirect_to "/pets/#{@pet.id}"
  end

  def remove_favorite_from_favorites
    @pet = Pet.find(params[:id])
    @pet[:favorite] = false
    @pet.save!
    flash[:notice] = "#{@pet.name} has been removed from your favorites list"
    redirect_to "/favorites"
  end

  def remove_all_favorites
    @favorites = Pet.favorited_pets
    @favorites.each do |favorite|
      favorite[:favorite] = false
      favorite.save!
    end
    redirect_to "/favorites"
  end

end
