class ProductsController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  before_action :categories

  require 'open-uri'
  require 'nokogiri'
  require 'date'

  def search_products
    if params[:q].present?
      product = Product.where("verified":"true")
      @products = product.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page
      render json:  @products
    end
  end

  def search_category_products
    if params[:q].present?
      products = Product.where(category_id: params[:category_id])
      @products = products.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page
      render json:  @products
    end
  end

  def fetch_data_from_url
    if params[:url].present?
      url = params[:url]
      if url == "https://gunprime.com/products/fn-america-fn15-patrol-carbine-556-nato-ar-15-ar15-36-100580"
        doc = Nokogiri::HTML(URI.open(url))
        @product_title = doc.css('//*[@id="product-description"]/h1/text()').to_s
        @product_price = 1220
        @product_store = doc.css('//*[@id="details"]/div/div[1]/span[2]/a/text()').to_s
        @product_category = doc.css('#similar_items_by_taxon > a:nth-child(2)/text()').to_s
        @product_caliber = doc.css('//*[@id="details"]/div/div[3]/span[2]/a/text()').to_s
        @product_brand = doc.css('//*[@id="sku-mpn-upc"]/div/div[4]/text()').to_s
        @product_mpn = doc.css('//*[@id="sku-mpn-upc"]/div/div[2]/text()').to_s
        @product_upc = doc.css('//*[@id="sku-mpn-upc"]/div/div[3]/text()').to_s
        @product_body = doc.css('#product-description > div.well > p:nth-child(1)').to_s
        @product_image = doc.css('#main-image > div > a > img').to_s
        @product_url = "https://gunprime.com/products/fn-america-fn15-patrol-carbine-556-nato-ar-15-ar15-36-100580"
        render json:  {title: @product_title, price: @product_price, store: @product_store, category: @product_category, caliber: @product_caliber, brand: @product_brand, mpn: @product_mpn, upc: @product_upc, body: @product_body, image: @product_image, pr_url: @product_url }

      elsif url == "https://gunprime.com/products/colt-python-357-mag-4-25-barrel-2020-stainless-steel-python-sp4wts"
        doc = Nokogiri::HTML(URI.open(url))
        @product_title = doc.css('//*[@id="product-description"]/h1/text()').to_s
        @product_price = 1315
        @product_store = doc.css('//*[@id="details"]/div/div[1]/span[2]/a/text()').to_s
        @product_category = doc.css('#similar_items_by_taxon > a:nth-child(2)/text()').to_s
        @product_caliber = doc.css('//*[@id="details"]/div/div[3]/span[2]/a/text()').to_s
        @product_brand = doc.css('//*[@id="sku-mpn-upc"]/div/div[4]/text()').to_s
        @product_mpn = doc.css('//*[@id="sku-mpn-upc"]/div/div[2]/text()').to_s
        @product_upc = doc.css('//*[@id="sku-mpn-upc"]/div/div[3]/text()').to_s
        @product_body = doc.css('#product-description > div.well > p:nth-child(1)').to_s
        @product_image = doc.css('#main-image > div > a > img').to_s
        @product_url = "https://gunprime.com/products/colt-python-357-mag-4-25-barrel-2020-stainless-steel-python-sp4wts"
        render json:  {title: @product_title, price: @product_price, store: @product_store, category: @product_category, caliber: @product_caliber, brand: @product_brand, mpn: @product_mpn, upc: @product_upc, body: @product_body, image: @product_image, pr_url: @product_url}
      else
        render json: {status: 'Url is not registered'}
      end

    end
  end

  def index
    @products = Product.where("verified":"true")
  end

  def new
    @product = Product.new
  end

  def create
    if user_signed_in?
      @product = current_user.products.new(product_params)
      @product.category_id = params[:product][:category_id]
      @product.store_id = params[:product][:store_id]
      @product.verified = "true"
      if @product.save
        redirect_to products_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_user_registration_path
    end
      end

  def show
    @comment = Comment.new
    @product = Product.find(params[:id])
    @products = Product.where(:upc => @product.upc, :active => true).where.not(:stock => nil )

  end

  def update
  end

  def edit
  end

  def destroy
  end


  # footer actions

  def today

    @products = Product.where(created_at: Date.today.all_day)
  end

  def category
    @category =  Category.find(params[:id])
    @products = Product.where(category_id: params[:id])
  end

  # Quicklink Routes
  def vulcan
    @categories = Category.all
    @products = Product.where(created_at: Date.today.all_day)
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

  def categories
    @categories = Category.all
  end

  def live_inventory_search
    @product = Product.find(params[:id])
    @products = Product.where(upc: @product.upc, active: true).where.not(stock: nil )
    @stock = Product.where(upc: @product.upc, stock: nil).or(Product.where( active: true, stock: "out of stock"))
    @similar_products = Product.where(:category_id => @product.category_id)
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
