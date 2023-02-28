class StoresController < ApplicationController
  before_action :categories, :coupons, :rebates, :comments

  def coupons
    @coupons = Coupon.all
  end

  def comments
    @comments = Comment.all
  end

  def rebates
    @rebates = Rebate.all
  end
  def categories
    @categories = Category.all
  end
  def index
    @categories = Category.all
    @stores = Store.all
  end


  def show
    @store = Store.find(params[:id])
    @products = Product.where(store_id: params[:id] )
    @categories = Category.all
  end


end
