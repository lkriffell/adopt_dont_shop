class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(review_params)
    review.update(shelter_id: @shelter.id)

    if params[:title] == "" || params[:rating] == "" || params[:content] == ""
      flash[:alert] = "You need to fill in a title, rating, and content in order to submit a shelter review"
      redirect_to "/shelters/#{@shelter.id}/new"
    else
      redirect_to "/shelters/#{@shelter.id}"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @shelter = Shelter.find(@review.shelter_id)
  end

  def update
    @review = Review.find(params[:id])
    @shelter = Shelter.find(@review.shelter_id)
    @review.update(review_params)
    @review.save
    if params[:title] == "" || params[:rating] == "" || params[:content] == ""
      flash[:alert] = "You need to fill in a title, rating, and content in order to update a shelter review"
      redirect_to "/shelters/#{@shelter.id}/#{@review.id}/edit"
    else
      redirect_to "/shelters/#{@shelter.id}"
    end

  end

  private
  def review_params
    params.permit(:title, :rating, :content, :shelter_id)
  end
end
