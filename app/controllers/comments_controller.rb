class CommentsController < ApplicationController
  def new
    @categories = Category.all
    @comment = Comment.new
  end

  def create
    if user_signed_in?
      @comment = current_user.comments.new(comments_params)
      @comment.body = params[:comment]
      @comment.product_id = params[:product_id]
      if @comment.save
        redirect_to product_path(@comment.product_id)
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_user_registration_path
    end
  end


  private
  def comments_params
    params.permit(:body, :image)
  end

end
