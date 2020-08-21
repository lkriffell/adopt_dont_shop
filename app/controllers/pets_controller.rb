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
end
