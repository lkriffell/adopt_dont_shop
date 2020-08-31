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
    string = ""
    params[:shelter].each do |param, value|
      if value == "" && string == ""
        string = "You must fill in"
        string += " #{param}"
      elsif value == ""
        string += " and #{param}"
      end
    end
    if string == ""
      redirect_to '/shelters'
    else
      flash[:alert] = string
      redirect_to '/shelters/new'
    end
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
    @shelter = Shelter.find(params[:id])
    @shelter.delete_shelter_references(@shelter.id)
    @shelter.destroy
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
