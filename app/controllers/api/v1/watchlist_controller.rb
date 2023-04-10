module Api
  module V1

class WatchlistController < Api::V1::ApiController
  def add_to_watchlist
      if params[:product_id].present? & params[:user_id].present?
        @watchlist = Watchlist.create(user_id:params[:user_id], product_id:params[:product_id])
        if @watchlist.save
          render json: {api_status: true,  watchlist: @watchlist.as_json( :include => [:product] )}
        else
          render json: {api_status: false,  error: 'user_id or product_id is not correct,They dont exist'}
        end

      else
        render json: {api_status: false,  error: 'product or user is missing Please provide both'}
      end
  end


end


end
  end