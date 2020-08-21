class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:shelter][:id])

      @shelter.update({
        name: params[:shelter][:name],
        address: params[:shelter][:address],
        city: params[:shelter][:city],
        state: params[:shelter][:state],
        zip: params[:shelter][:zip]
      })
    @shelter.save
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def show_pets
    @shelter = Shelter.find(params[:id])
    @pets_at_location =
    Pet.all.find_all do |pet|
      pet.shelter_id == @shelter.id
    end
  end
end
