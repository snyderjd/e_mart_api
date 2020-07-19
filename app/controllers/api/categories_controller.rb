class Api::CategoriesController < ApplicationController
    before_action :authorize_as_admin, only: [:create]

    # GET to /api/categories - gets all categories
    def index
        @categories = Category.all
        render json: @categories
    end

    # POST to /api/categories - creates a category and saves it to the DB
    def create
        @category = Category.new(category_params)
        if @category.save
            render json: @category
        else
            render json: @category.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

end

