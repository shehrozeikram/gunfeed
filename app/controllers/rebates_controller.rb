class RebatesController < ApplicationController
  before_action :categories
  def categories
    @categories = Category.all
  end
  def index
    @rebates = Rebate.all
  end

  def new
  end

end
