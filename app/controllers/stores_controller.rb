class StoresController < ApplicationController
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
