class ProductsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new

    # url = "https://gunprime.com/products/fn-america-fn15-patrol-carbine-556-nato-ar-15-ar15-36-100580"
    # doc = Nokogiri::HTML(URI.open(url))
    # @product_title = doc.css('//*[@id="product-description"]/h1/text()')
    # @product_price = doc.css('#product-price > div:nth-child(2) > span.lead.original-price.selling.text()')
    # @product_store = doc.css('//*[@id="details"]/div/div[1]/span[2]/a/text()')
    # @product_category = doc.css('#similar_items_by_taxon > a:nth-child(2)/text()')
    # @product_caliber = doc.css('//*[@id="details"]/div/div[3]/span[2]/a/text()')
    # @product_brand = doc.css('//*[@id="sku-mpn-upc"]/div/div[4]/text()')
    # @product_mpn = doc.css('//*[@id="sku-mpn-upc"]/div/div[2]/text()')
    # @product_upc = doc.css('//*[@id="sku-mpn-upc"]/div/div[3]/text()')
    # @product_image = doc.css('//*[@id="main-image"]/div/a[1]/img')


    @product = Product.new
  end

  def create
    if user_signed_in?
      @product = current_user.products.new(product_params)
      if @product.save
        redirect_to products_path
      else
        render :new, status: :unprocessable_entity
      end
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
