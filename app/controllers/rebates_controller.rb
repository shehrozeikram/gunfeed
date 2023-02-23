class RebatesController < ApplicationController

  before_action :categories, :coupons, :rebates, :comments
  def index
    @rebates = Rebate.all
  end

  def new
  end

  def categories
    @categories = Category.all
  end

  def coupons
    @coupons = Coupon.all
  end

  def comments
    @comments = Comment.all
  end

  def rebates
    @rebates = Rebate.all
  end

end
