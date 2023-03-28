class MyAccountsController < ApplicationController
  before_action :authenticate_user!, only: [:user_deals]
  before_action :categories, :coupons, :rebates, :comments, :user

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
  def views
  end

  def my_messages
  end

  def blocked_deal_settings
  end

  def user_deals
    @products =  current_user.products
  end

  def user_comments
    @comments = current_user.comments
  end

  def user_votes
    @products = current_user
  end

  def my_reviews
    @reviews = current_user.reviews
  end

  def my_watchlist
    @watchlist = Watchlist.where(user_id:current_user.id)
  end

  def user
    @user = current_user
  end

end
