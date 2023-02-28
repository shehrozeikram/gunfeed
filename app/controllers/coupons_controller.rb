class CouponsController < ApplicationController

  before_action :authenticate_user!, only: [:new]
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

  def index
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    if user_signed_in?
      @coupon = Coupon.new(coupon_params)
      @coupon.store_id = params[:coupon][:store_id]
      @coupon.coupon_code = params[:coupon][:coupon_code]
      @coupon.discount = params[:coupon][:discount]
      # @coupon.coupon_link = params[:coupon][:coupon_link]
      @coupon.unknown_expiration = params[:coupon][:unknown_expiration]

      if @coupon.save
        redirect_to coupons_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_user_registration_path
    end
  end


  def edit
  end


  private

  def coupon_params
    params.permit( :store_id, :discount, :coupon_code, :start_date, :expiration_date, :unknown_expiration)
  end
end
