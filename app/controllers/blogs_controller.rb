class BlogsController < ApplicationController
  def fetch_blogs
    @blogs = Blog.all
    @categories = Category.all
  end

  def show
    @blog = Blog.find(params[:id])
    @categories = Category.all
  end

end
