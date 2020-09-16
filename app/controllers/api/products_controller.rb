class Api::ProductsController < ApplicationController
    before_action :authorize_as_admin, only: [:create, :update, :destroy]

    # # Use Knock to make sure the current_user is authenticated before completing request
    # before_action :authenticate_user, only: [:index, :current, :update]
    # before_action :authorize_as_admin, only: [:destroy]
    # before_action :authorize, only: [:update]

    # GET to /api/products - gets all products
    def index
        if params[:q]
            string = params[:q].downcase

            # Include products where name or description contains the query param
            @products = Product.where(
                "lower(name) LIKE :q OR lower(description) LIKE :q", 
                q: "%#{string}%", 
                q: "%#{string}%")

            render json: @products
        elsif params[:category_id]

            # Include products with the category_id
            @products = Product.where("category_id = ?", params[:category_id])
            render json: @products 
        else
            @products = Product.all
            render json: @products
        end
    end

    # GET to /api/products/id - gets one product
    def show
        @product = Product.find(params[:id])
        render json: @product
    end

    # POST to /api/products - creates a new product and saves it to the DB
    def create
        @product = Product.new(product_params)
        if @product.save
            render json: @product
        else
            render json: @product.errors.full_messages, status: :unprocessable_entity
        end
    end

    # PUT/PATCH to /api/products/id - updates a product and saves it to the DB
    def update
        @product = Product.find(params[:id])

        if @product.update_attributes(product_params)
            render json: @product
        else
            render json: @product.errors.full_messages, status: :unprocessable_entity
        end
    end

    # DELETE to /api/products/id - deletes a product
    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        render json: @product
    end

    # DELETE to /api/products/id/image - deletes a product's image
    def destroy_image
        @product = Product.find(params[:product_id])
        @product.image.purge
        render json: @product
    end

    private

    def product_params
        params.permit(:name, :description, :category_id, :price, :quantity, :is_active, :image)
    end

    # Handles searching, filtering, and sorting of products as necessary
    def searchFilterSortProducts
        products = []
        search_string = params[:q] ?? params[:q].downcase : ""

        if params[:q] && params[:category_id]
            # Search and filter

            products = Product.where(
                "lower(name) LIKE :q OR lower(description) LIKE :q
                AND category_id = :category_id",
                q: "%#{search_string}%",
                q: "%#{search_string}%",
                category_id: params[:category_id]
            )

        elsif params[:q] && !params[:category_id]
            # Search, no filter
            products = Product.where(
                "lower(name) LIKE :q OR lower(description) LIKE :q",
                q: "%#{search_string}%",
                q: "%#{search_string}%"
            )

        elsif !params[:q] && params[:category_id]
            # No search, filter
            products = Product.where("category_id = ?", params[:category_id])
        else
            # No search, No filter
            products = Product.all
        end

        # Sort the products by price, low to high
        if params[:sort] === "price_ascending"

        end

        # Sort the products by price, high to low
        if params[:sort] === "price_descending"

        end

        products
    end

    # if params[:q]
    #     string = params[:q].downcase

    #     # Include products where name or description contains the query param
    #     @products = Product.where(
    #         "lower(name) LIKE :q OR lower(description) LIKE :q", 
    #         q: "%#{string}%", 
    #         q: "%#{string}%")

    #     render json: @products
    # elsif params[:category_id]

    #     # Include products with the category_id
    #     @products = Product.where("category_id = ?", params[:category_id])
    #     render json: @products 
    # else
    #     @products = Product.all
    #     render json: @products
    # end

end