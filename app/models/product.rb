class Product < ApplicationRecord
    include Rails.application.routes.url_helpers

    attr_accessor :image_url

    validates :name, :description, :category_id, :price, :quantity, presence: true

    # Can't use presence validation with boolean field
    validates :is_active, inclusion: { in: [true, false] }

    # Associations
    belongs_to :category
    has_many :order_products
    has_many :reviews

    has_one_attached :image

    def image_url
        # If the product has an image attached, return its url
        if self.image.attached?
            return url_for(self.image)
        else
            return "No image"
        end
    end
end

