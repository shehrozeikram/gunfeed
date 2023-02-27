class NewsLetterController < ApplicationController
  # before_action :authenticate_user!, only: [:new]

  skip_before_action :verify_authenticity_token
  def index
  end

  def new
    @news_letter = NewsLetter.new
  end

  def create
    if params[:email].present?
    @news_letter = NewsLetter.new(newsletter_params)
      @news_letter.subscribed = true

      if @news_letter.save
        redirect_to products_path
      else
        render :'news_letter/new', status: :unprocessable_entity
      end
    end
  end

  def subscribe_to_newsletter
    if params[:id].present?
      @user = User.find(params[:id])
      @user.subscribed == true
      @user.save
      render json:  @user
    else
      render json: @user.errors.full_messages
      end
  end

  private

  def newsletter_params
    params.permit(:subscribed, :user_id, :email)
  end

end
