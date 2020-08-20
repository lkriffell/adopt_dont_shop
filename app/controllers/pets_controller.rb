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
    if params[:pet][:name] != ""
      @pet.update({ name: params[:pet][:name] })
    elsif params[:pet][:approximate_age] != ""
      @pet.update({ approximate_age: params[:pet][:approximate_age] })
    elsif params[:pet][:sex] != ""
      @pet.update({ sex: params[:pet][:sex] })
    elsif params[:pet][:current_location] != ""
      @pet.update({ current_location: params[:pet][:current_location] })
    elsif params[:pet][:image] != ""
      @pet.update({ image: params[:pet][:image] })
    end

      @pet.save
      redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end
end
