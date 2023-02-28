class MyAccountsController < ApplicationController
  before_action :user
  before_action :categories
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
  end

  def user_comments
    @comments = current_user.comments
  end

  def user_votes
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
