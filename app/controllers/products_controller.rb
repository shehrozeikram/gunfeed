class ProductsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :recent_comments, :like_product, :unlike_product, :map_price]
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

  require 'open-uri'
  require 'nokogiri'
  require 'date'

  def categories
    @categories = Category.all
  end
  def search_products
    if params[:q].present?
      @products = Product.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").limit(20).or(Product.where("LOWER(upc) LIKE LOWER(?)", "%#{params[:q]}%").limit(20)).or(Product.where("LOWER(mpn) LIKE LOWER(?)", "%#{params[:q]}%").limit(20))
      render json:  @products
    end
  end

  def search_compare_guns
    if params[:q].present?
      @products = Product.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page
      render json:  @products
    end
  end

  def select_gun
    if params[:id].present?
      @product = Product.friendly.find(params[:id])
      render json:  @product
    end
  end

  def like_product
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      if already_liked?
        @already_liked_product = @product.likes.all.count
        render json: {already_liked_product: @already_unliked_product, error: "You can't like more than once"}
      else
        @like_product =  @product.likes.create(
          user_id: current_user.id,
          user_like: 1
        )
        @like_product.save
        @like_product.total_likes =  Like.all.count
        @like_product.save
        render json: @like_product
      end
      else
      render json: @like_product, error: 'product_id is not present'
    end
  end

  def unlike_product
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      if already_unliked?
        @already_unliked_product = @product.unlikes.all.count
        render json: {already_unliked_product: @already_unliked_product, error: "You can't unlike more than once"}
      else
        @unlike_product =  @product.unlikes.create(
          user_id: current_user.id,
          user_unlike: 1
        )
        @unlike_product.save
        @unlike_product.total_unlikes =  Unlike.all.count
        @unlike_product.save
        render json: @unlike_product
      end
    else
      render json: @unlike_product, error: 'product_id is not present'
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
    @products.each do |pr|
      pr.id
      @product = Product.find(pr.id)
    end
    if @products.present?
      @similar_products = Product.where(category_id: @products.last.category_id).where.not(id: @products.last.id ).limit(20)
      @product_2 = Product.where(category_id: @products.last.category_id ).where.not(id: @products.last.id).last
    end
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
      if params[:rimfire] == '1'
        @product.deal_type = 'used'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:ninteen_eleven] == '1'
        @product.deal_type = 'ninteen_eleven'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:california_legal] == '1'
        @product.deal_type = 'california_legal'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:ar] == '1'
        @product.deal_type = 'ar'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:revolver] == '1'
        @product.deal_type = 'revolver'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:c_and_r] == '1'
        @product.deal_type = 'c_and_r'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:ak] == '1'
        @product.deal_type = 'ak'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end
      elsif params[:used] == '1'
        @product.deal_type = 'used'
        if @product.save

          redirect_to products_path
        else
          render :new, status: :unprocessable_entity
        end

      else
        @product.save
        redirect_to products_path
      end

    else
      redirect_to new_user_registration_path
    end
  end

  def show
    @comment = Comment.new
    @product = Product.friendly.find(params[:id])
    @products = Product.where(upc: @product.upc ).where.not(stock: nil).where.not(id: @product.id).where.not(stock:"out of stock").limit(50)
    @similar_products = Product.where(category_id: @product.category_id).where.not(id: @product.id ).limit(20)
    @product_2 = Product.where(category_id: @product.category_id ).where.not(id: @product.id).last

    if current_user.present?
      @recently_viewed = current_user.recently_vieweds.new(recent_params)
      @recently_viewed.product_id = @product.id
      @recently_viewed.save
      @recently_viewed_products = current_user.recently_vieweds.last(5)
    end
  end

  # footer actions

  def today
    @products = Product.where(created_at: Date.yesterday.all_day)
  end

  def popular
    @products = Product.where(is_popular: true )
  end

  def category
    @category =  Category.find(params[:id])
    @products = Product.where(category_id: params[:id])
  end

  # Quicklink Routes
  def vulcan
    # @categories = Category.all
    # @products = Product.where(created_at: Date.today.all_day)
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

  def create_coupon

  end


  def map_price
    if current_user
      @user = current_user
      @user_email = @user.email
      if params[:product_id].present?
        @product = Product.find(params[:product_id])
        end
      # PriceMailer.with(user_email:@user_email,product: @product ).map_price.deliver_now!
      render json: @user_email
    else
      render json error: 'Please login '
    end
  end


  def logout_map_price
    if params[:email].present?
      @user_email = params[:email]
      if params[:product_id].present?
        @product = Product.find(params[:product_id])
      end
      # PriceMailer.with(user_email:@user_email,product: @product ).map_price.deliver_now!
      render json: @user_email
    else
      render json error: 'Sorry for the trouble there is an internal error '
    end
  end

  def logout_email
    if params[:email].present?
      @email = Email.new(email_params)
      if @email.save
        redirect_to products_path(@product)
      else
        render :'products/index', status: :unprocessable_entity
      end
    end
  end
  def live_inventory_search
    @product = Product.friendly.find(params[:id])
    @product_2 = Product.where(category_id: @product.category_id ).where.not(id: @product.id).last
    @products = Product.where(upc: @product.upc ).where.not(stock: nil).where.not(id: @product.id).where.not(stock: 'out of stock').limit(50)
    # @stock = Product.where(upc: @product.upc, stock: nil).or(Product.where(upc: @product.upc, stock: 'out of stock')).limit(50)
    @stock = Product.where(upc: @product.upc, stock: nil).limit(50) || Product.where(upc: @product.upc, stock: 'out of stock').limit(50)
    @similar_products = Product.where(category_id: @product.category_id).where.not(id: @product.id ).limit(20)
    if current_user.present?
      @user_products = current_user.products.where(verified: "true")
    end
  end

  def video_review
    @video_review = VideoReview.new(video_review_params)
    if @video_review.save
      redirect_to '/'
    else
      render :'products/index', status: :unprocessable_entity
    end
  end

  def compare_guns
    if (params[:product_id] && params[:compared_product_id]).present?

      @product = Product.find(params[:product_id]) rescue nil
      @compared_product = Product.find(params[:compared_product_id]) rescue nil

      @products = Product.where(upc: @product.upc ).where.not(stock: nil).where.not(id: @product.id).where.not(stock: 0).limit(50)
      @compared_products = Product.where(upc: @compared_product.upc ).where.not(stock: nil).where.not(id: @compared_product.id).where.not(stock: 0).limit(50)

      product_id =  Product.where(id:@product.id).last
      product_category_id = product_id.category_id

      @product_3 = Product.where(category_id: product_category_id ).where.not(id: @product.id).first
      @product_4 = Product.where(category_id: product_category_id ).where.not(id: @product.id).second
      @product_5 = Product.where(category_id: product_category_id ).where.not(id: @product.id).third

      # comparison method

      @product_2 = Product.find(params[:compared_product_id]) rescue nil
      product2_id =  Product.where(id:@product_2.id).last
      product_category_id = product2_id.category_id

      @product_6 = Product.where(category_id: product_category_id ).where.not(id: @product_2.id).fourth
      @product_7 = Product.where(category_id: product_category_id ).where.not(id: @product_2.id).fifth
      @product_8 = Product.where(category_id: product_category_id ).where.not(id: @product_2.id).last

    end
  end

  def recent_comments
    @comments = current_user.comments.all
  end

  def notify_me
    if params[:email].present?
      @notify_me = NotifyMe.new(notify_params)
      if @notify_me.save
        redirect_to products_path(@product)
      else
        render :'products/index', status: :unprocessable_entity
      end
    end
  end

  def report_product
    @report = ReportProblem.new(report_params)
    if @report.save
      redirect_to products_path(@product)
    else
      render :'products/index', status: :unprocessable_entity
    end
  end

  # Product Quicklink methods
  def revolvers
    @products = Product.where(revolver: true)
  end
  def rimfire
    @products = Product.where(rimfire: true )
  end

  def c_and_r
    @products = Product.where(c_and_r: true )
  end

  def ar_deals
    @products = Product.where(ar: true )
  end

  def ak_deals
    @products = Product.where(ak: true )
  end

  def twenty_two_lr_ammo
    @products = Product.where(twenty_two_lr_ammo: true )
  end

  def nine_mm_ammo
    @products = Product.where(nine_mm_ammo: true )
  end

  def used_guns
    @products = Product.where(used: true )
  end

  protected

  def already_liked?
    Like.where(user_id: current_user.id, product_id:
      params[:product_id]).exists?
  end

  def already_unliked?
    Unlike.where(user_id: current_user.id, product_id:
      params[:product_id]).exists?
  end

  def recent_params
    params.permit(:user_id, :product_id)
  end

  def report_params
    params.permit(:problem_with, :problem_details)
  end

  def notify_params
    params.permit(:upc, :limite_price, :email)
  end

  def video_review_params
    params.permit(:link, :product_id)
  end
  def email_params
    params.permit(:email)
  end

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
      :image,
      :rimfire,
      :ninteen_eleven,
      :california_legal,
      :ar,
      :revolver,
      :c_and_r,
      :ak,
      :used,
      :deal_type,
      :expires,
      :expired,
      :out_of_stock,
      :bump_this_post,
      :total_likes,
      :total_unlikes,
      :total_comments,
      :total_reviews,
      :total_rebates
    )
  end

end
