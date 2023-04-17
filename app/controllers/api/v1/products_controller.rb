
module Api
  module V1

class ProductsController < Api::V1::ApiController
  def index
    @products = Product.where("verified":"true")
    if @products.all.count == 0
      render json: {api_status: false,  products: 'No products found'}
    else
      @products.each do |pr|
        pr.id
        @product = Product.find(pr.id)
      end
      render json: {api_status: true,  products: @products.as_json( :include => [:category] )}
    end
  end

  def search_products
    if params[:q].present?
      @products = Product.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").limit(20).or(Product.where("LOWER(upc) LIKE LOWER(?)", "%#{params[:q]}%").limit(20)).or(Product.where("LOWER(mpn) LIKE LOWER(?)", "%#{params[:q]}%").limit(20))
      if @products.all.count == 0
        render json: {api_status: false,  products: 'No products found'}
      else
        render json: {api_status: true,  search_products: @products.as_json( :include => [:category] )}
      end
    else
      render json: {api_status: false ,  error: 'params is missing or value is not present in our database'}
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

  def show
    if params[:id].present?
      @product = Product.find(params[:id])
        render json: {api_status: true,  product: @product.as_json( :include => [:category] )}
    else
      render json: {api_status: false ,  error: 'params is missing or value is not present in our database'}
    end
  end

  # footer actions

  def today
    @products = Product.where(created_at: Date.today.all_day)
    if @products.all.count == 0
      render json: {api_status: false,  products: 'No products found'}
    else
      render json: {api_status: true,  products: @products.as_json( :include => [:category] )}
    end
  end

  def popular
    @products = Product.where(is_popular: true )
    if @products.all.count == 0
      render json: {api_status: false,  products: 'No products found'}
    else
      render json: {api_status: true,  products: @products.as_json( :include => [:category] )}
    end
  end


  def fetch_categories
    @categories = Category.all.order(name: :asc)
    if @categories.all.count == 0
      render json: {api_status: false,  error: 'No category found'}
    else
      render json: {api_status: true,  categories: @categories}
    end
  end

  def show_category_products
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id])
      if @products.all.count == 0
        render json: {api_status: false,  error: 'No product found'}
      else
        render json: {api_status: true,  categories_products: @products}
      end
    else
      render json: {api_status: false ,  error: 'params is missing or value is not present in our database'}
    end
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
      PriceMailer.with(user_email:@user_email,product: @product ).map_price.deliver_now!
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
      PriceMailer.with(user_email:@user_email,product: @product ).map_price.deliver_now!
      render json: @user_email
    else
      render json error: 'Sorry for the trouble there is an internal error '
    end
  end


  def live_inventory_search
    if params[:id].present?
      @product = Product.find(params[:id])
      @products = Product.where(upc: @product.upc ).where.not(stock: nil).where.not(id: @product.id).where.not(stock: 'out of stock').limit(50)
      @stock = Product.where(upc: @product.upc, stock: nil).or(Product.where(upc: @product.upc, stock: 'out of stock')).limit(50)
      @similar_products = Product.where(category_id: @product.category_id).where.not(id: @product.id ).limit(20)
      if params[:user_id].present?
        user = User.find(params[:user_id])
        @deals = user.products.where(verified: "true")
        if @deals.any?
          render json: {api_status: true,  product: @product.as_json( :include => [:category] ), similar_products: @similar_products, live_inventory_products: @products, out_of_stock_products: @stock, deals: @deals  }
        else
          render json: {api_status: true,  product: @product.as_json( :include => [:category] ), similar_products: @similar_products, live_inventory_products: @products, out_of_stock_products: @stock, deals: 'Sorry this user has no other deal'  }
        end
      else
        render json: {api_status: true,  product: @product.as_json( :include => [:category] ), similar_products: @similar_products, live_inventory_products: @products, out_of_stock_products: @stock, deals: 'No deal found'  }
      end
    else
      render json: {api_status: false,  error: 'Please provide id of product'}
    end

  end

  def create_comment
    if params[:user_id].present?
      user = User.where(id: params[:user_id]).last
      @comment = user.comments.new(comments_params)
      if @comment.save
        render json: {api_status: true,  comment: @comment}
      else
        render json: {api_status: false,  error: @comment.errors}
      end
    else
      render json: {api_status: false,  error: 'Please provide id of user'}
    end
  end

  def recent_comments
    if params[:id].present?
      @product = Product.find(params[:id])
        @comments = @product.comments.all
        @comments_count = @product.comments.all.count
        if @comments.all.count == 0
          render json: {api_status: false,  error: 'No comment found'}
        else
          render json: {api_status: true,  comments: @comments, comments_count: @comments_count}
        end
    else
      render json: {api_status: false,  error: 'user id is not correct'}
    end
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

  def quick_links
    if params[:deal_type].present?
      if params[:deal_type] == 'revolver'
        @products = Product.where(revolver: true)
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'rimfire'
        @products = Product.where(rimfire: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'c_and_r'
        @products = Product.where(c_and_r: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'ar'
        @products = Product.where(ar: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'ak'
        @products = Product.where(ak: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'twenty_two_lr_ammo'
        @products = Product.where(twenty_two_lr_ammo: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'nine_mm_ammo'
        @products = Product.where(nine_mm_ammo: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      elsif params[:deal_type] == 'used'
        @products = Product.where(used: true )
        render json: {api_status: true ,  products: @products.as_json( :include => [:category] )}
      else
        render json: {api_status: false ,  error: 'Please provide valid deal_type'}
      end


    else
      render json: {api_status: false ,  error: 'deal_type is missing or value is not present in our database'}
    end
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
      :image
    )
  end

  def comments_params
    params.permit(:body, :image, :product_id)
  end



end
  end
   end