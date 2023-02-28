class BlogsController < ApplicationController
  before_action :categories
  def categories
    @categories = Category.all
  end
  def fetch_blogs
    @blogs = Blog.all
    @categories = Category.all
  end

  def show
    @blog = Blog.find(params[:id])
    @products = Product.where(upc: @blog.product.upc, active: true).where.not(stock: nil )
    @products.all.where.not(stock: 'out of stock')
    @categories = Category.all
  end

end
