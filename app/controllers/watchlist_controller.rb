class WatchlistController < ApplicationController
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

  def add_to_watchlist
    if params[:watchlist].present?
      @watchlist = Watchlist.create(user_id:current_user.id, product_id:params[:product_id])
      if @watchlist.save
        render json: {api_status: true,  watchlist: @watchlist}
      else
        render json: {api_status: false,  error: 'product or user is missing Please provide both'}
      end
    end
  end

end
