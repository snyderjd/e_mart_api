class Order < ApplicationRecord
  validates :user_id, :total_cost, presence: true

  # Can't user presence validation with boolean field
  validates :is_complete, inclusion: { in: [true, false] }

  # Associations
  belongs_to :user
  has_many :order_products
  has_many :products, :through => :order_products

  # after_initialize :compute_total_cost

  # # Computes the total cost by adding up the cost of every product associated with the order
  # def compute_total_cost
  #   product_costs = []

  #   # Get all the products associated with this order
  #   products = Product.joins()

  #   # Put the price of each product into the product_costs array
  #   products.each do |product| 
  #     product_costs << product.price
  #   end
    
  #   # Set the order's total_cost to the sum of the product_costs array
  #   self.total_cost = product_costs.sum()
  # end

  # Calculates and updates an order's total cost, which is the sum of prices for all the products on that order
  def calculate_total_cost
    total_cost = 0;

    self.products.each do |product|
      total_cost += product.price
    end

    self.total_cost = total_cost
  end

end