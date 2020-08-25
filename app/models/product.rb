class Product < ApplicationRecord
    validates :name, :description, :category_id, :price, :quantity, presence: true

    # Can't use presencce validation with boolean field
    validates :is_active, inclusion: { in: [true, false] }

    # Associations
    belongs_to :category
    has_many :order_products
end

