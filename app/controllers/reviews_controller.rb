class ReviewsController < ApplicationController
  before_action :categories
  def categories
    @categories = Category.all
  end
  def new
    @categories = Category.all
    @review = Review.new
  end

  def create
    if user_signed_in?
      @review = current_user.reviews.new(reviews_params)
      @review.product_id = '94'
      if @review.save
        redirect_to new_review_path
      else
        render :new, status: :unprocessable_entity
      end
      else
        redirect_to new_user_registration_path
      end
  end


  protected
  def reviews_params
    params.permit(:body, :image)
  end
end
