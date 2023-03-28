class BlogsController < ApplicationController
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
