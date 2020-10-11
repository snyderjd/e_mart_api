class Api::ReviewsController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request
  before_action :authenticate_user, only: [:create, :update, :destroy]

  # GET to /api/products/:product_id/reviews - gets all the reviews for a product
  def index
    @reviews = Review.where("product_id = ?", params[:product_id]);

    render json: @reviews
  end

  # GET to /api/reviews/:id - gets a single review
  def show
    @review = Review.find(params[:id])

    render json: @review
  end

  # POST to /api/products/:product_id/reviews - creates a review for a product and saves to the DB
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      render json: @review
    else
      render json: @review.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PUT/PATCH to /api/reviews/:id - updates a review for a product and saves to the DB
  def update
    @review = Review.find(params[:id])

    if @review.user_id == current_user.id
      if @review.update_attributes(review_params)
        render json: @review
      else
        render json: @review.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: "Users can only edit their own reviews"
    end
  end

  # DELETE to /api/reviews/:id - deletes a review from the DB
  def destroy
    @review = Review.find(params[:id])

    # Users can delete their own reviews, or admins can delete any review
    if current_user.id == @review.user_id || current_user.is_admin?
      @review.destroy
      render json: @review
    else
      render json: "Can't delete other users' reviews"
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :product_id, :rating, :title, :body)
  end

end


