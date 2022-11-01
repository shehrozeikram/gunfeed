class ProductsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def index
    @products = Product.all
  end

  def new

    # doc = Nokogiri::HTML(open("https://gunprime.com/products/fn-america-fn15-patrol-carbine-556-nato-ar-15-ar15-36-100580"))
    # @product = doc.css('.lead')

    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
  end

  def edit
  end

  def destroy
  end


  # footer actions

  def today
  end

  def about_us
  end

  def contact_us
  end

  def FAQ
  end

  def newsletter
  end

  def moderator
  end

  def banners
  end

  def giveaways
  end

  def banner_ads
  end

  def dealers_advertising
  end

  def trusted_retailer_program
  end

  def dealers_api_access
  end

  def terms_service
  end

  def privacy_policy
  end

  def refund_policy
  end

  def how_order_gun_online
  end

  protected
  def product_params
    params.permit(
      :product_url,
      :title,
      :price,
      :store,
      :amount,
      :category,
      :caliber,
      :brand,
      :mpn,
      :upc,
      :body,
      :image
    )
  end

end
