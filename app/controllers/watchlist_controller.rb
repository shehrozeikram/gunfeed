class WatchlistController < ApplicationController

  def add_to_watchlist
    if params[:watchlist].present?
      @watchlist = Watchlist.create(user_id:current_user.id, product_id:params[:product_id])
      if @watchlist.save
        render json:  @watchlist
      else
        render json:  'Bad entity'
      end
    end
  end

end
