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
    shelter = Shelter.find(params[:shelter][:id])
    if params[:shelter][:name] != ""
      shelter.update({ name: params[:shelter][:name] })
    elsif params[:shelter][:address] != ""
      shelter.update({ address: params[:shelter][:address] })
    elsif params[:shelter][:city] != ""
      shelter.update({ city: params[:shelter][:city] })
    elsif params[:shelter][:state] != ""
      shelter.update({ state: params[:shelter][:state] })
    elsif params[:shelter][:zip] != ""
      shelter.update({ zip: params[:shelter][:zip] })
    end

    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def show_pets
    @shelter = Shelter.find(params[:id])
    @pets_at_location = []
    Pet.all.each do |pet|
      if pet.shelter_id == @shelter.id
        @pets_at_location << pet
      end
    end
  end
end
