class Product < ApplicationRecord
    validates :name, :description, :category_id, :price, :quantity, presence: true

    # Can't use presencce validation with boolean field
    validates :is_active, inclusion: { in: [true, false] }

    belongs_to :category
end

