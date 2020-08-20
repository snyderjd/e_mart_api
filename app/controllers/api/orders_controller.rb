class Api::OrdersController < ApplicationController
  before_action :authenticate_user

  # GET to /api/orders - gets all of a user's completed orders
  def index
    # orders = current_user.orders.find(is_complete: true)
    orders = current_user.orders

    if params[:is_complete]
      # Return the orders that are not complete yet (each user should only have one, which is their cart)
      current_user.orders.each do |order|
        if order.is_complete == false
          render json: order
        end
      end
    else
      # Return all of the user's orders
      render json: orders
    end
  end

  # GET to /api/orders/id
  def show
    order = current_user.orders.find(params[:id])
    render json: order
  end

  # POST to /api/orders - creates a new order and saves it to the DB
  def create
    order = Order.new(order_params)
    order.user_id = current_user.id
    order.total_cost = 0

    if order.save
      render json: order
    else
      render json: order.errors.full_messages, status: :unprocessable_entity
    end
  end

  # POST to /api/orders/:order_id/products - adds a product to the user's cart (their current active order)
  def add_product
    order = Order.find(params[:id])
    product = Product.find(params[:product_id])

    order.products << product
    render json: order
  end

  # DELETE to /api/orders/:order_id/products - removes a product from the user's cart (their current active order)
  def remove_product
    order = Order.find(params[:id])
    product = Product.find(params[:product_id])

    order.products.delete(product)
    render json: order
  end

  # DELETE to /api/orders/id - deletes an order
  def destroy
    order = Order.find(params[:id])

    # Can't delete other users' orders
    if order.user_id == current_user.id
      order.destroy
      render json: order
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :is_complete, :total_cost)
  end

end
