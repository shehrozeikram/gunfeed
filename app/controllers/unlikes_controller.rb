class UnlikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_product

  def create
    if already_unliked?
      flash[:notice] = "You can't unlike more than once"
    else
      @product.unlikes.create(user_id: current_user.id)
    end
    redirect_to product_path(@product)
  end



  private

  def already_unliked?
    Unlike.where(user_id: current_user.id, product_id:
      params[:product_id]).exists?
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

end
