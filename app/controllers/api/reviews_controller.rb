class Api::ReviewsController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request
  before_action :authenticate_user, only: [:create, :update, :destroy]

  # GET to /api/products/:product_id/reviews - gets all the reviews for a product
  def index

  end

  def show

  end

  # POST to /api/products/:product_id/reviews - creates a review for a product
  def create

  end

  def update

  end

  def destroy
    
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :product_id, :rating, :title, :body)
  end

end

# class Api::ProductsController < ApplicationController
#   before_action :authorize_as_admin, only: [:create, :update, :destroy]

#   # # Use Knock to make sure the current_user is authenticated before completing request
#   # before_action :authenticate_user, only: [:index, :current, :update]
#   # before_action :authorize_as_admin, only: [:destroy]
#   # before_action :authorize, only: [:update]

#   # GET to /api/products - gets all products
#   def index
#       @products = search_filter_products

#       @products = sort_products(@products).paginate(page: params[:page], per_page: 5)
#       total_count = @products.count

#       # render serialized products with metadata for pagination
#       render json: @products, 
#                   meta: {total_entries: @products.total_entries}, 
#                   adapter: :json
#   end

#   # GET to /api/products/id - gets one product
#   def show
#       @product = Product.find(params[:id])
#       render json: @product
#   end

#   # POST to /api/products - creates a new product and saves it to the DB
#   def create
#       @product = Product.new(product_params)
#       if @product.save
#           render json: @product
#       else
#           render json: @product.errors.full_messages, status: :unprocessable_entity
#       end
#   end

#   # PUT/PATCH to /api/products/id - updates a product and saves it to the DB
#   def update
#       @product = Product.find(params[:id])

#       if @product.update_attributes(product_params)
#           render json: @product
#       else
#           render json: @product.errors.full_messages, status: :unprocessable_entity
#       end
#   end

#   # DELETE to /api/products/id - deletes a product
#   def destroy
#       @product = Product.find(params[:id])
#       @product.destroy
#       render json: @product
#   end

#   private

#   def product_params
#       params.permit(:name, :description, :category_id, :price, :quantity, :is_active, :image)
#   end

# end