class ProductsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'date'



  def index
    @products = Product.all
    @categories = Category.all
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

    # @categories = Category.all.to_a.map{ |c| [c.name, c.id]}
    @categories = Category.all
    @product = Product.new
  end

  def create
    if user_signed_in?
      @product = current_user.products.new(product_params)
      @product.category_id = params[:product][:category_id]
      # category = @product.category
      # @product.category = category
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
    @categories = Category.all
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
    @categories = Category.all
    @products = Product.where(created_at: Date.today.all_day)
  end

  def category
    @categories = Category.all
    @category =  Category.find(params[:id])
    @products = Product.where(category_id: params[:id])
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
