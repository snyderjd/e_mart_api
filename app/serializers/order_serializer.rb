class OrderSerializer < ActiveModel::Serializer
  attributes  :id, 
              :user, 
              :is_complete, 
              :total_cost, 
              :created_at, 
              :updated_at, 
              :products

  # Return the image_url for each product
  def products
    customized_products = []

    object.products.each do |product|
      custom_product = product.attributes
      custom_product[:image_url] = product.image_url

      customized_products << custom_product
    end

    return customized_products
  end
end
