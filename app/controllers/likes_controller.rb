class LikesController < ApplicationController
  before_action :find_product

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @product.likes.create(user_id: current_user.id)
    end
    redirect_to product_path(@product)
  end



  private

  def already_liked?
    Like.where(user_id: current_user.id, product_id:
      params[:product_id]).exists?
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

end
