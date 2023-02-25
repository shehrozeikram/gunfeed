class RebatesController < ApplicationController

  def index
    @rebates = Rebate.all
  end

  def new
  end

end
