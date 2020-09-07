class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :quantity, :category_id, :category, :price, :is_active, :image, :image_url
end
