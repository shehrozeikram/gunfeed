class MyAccountsController < ApplicationController
  before_action :categories
  before_action :user

  def views
  end

  def my_messages
  end

  def blocked_deal_settings
  end

  def user_deals
  end

  def user_comments
  end

  def user_votes
  end

  def my_reviews
  end

  def categories
    @categories = Category.all
  end

  def user
    @user = current_user
  end

end
