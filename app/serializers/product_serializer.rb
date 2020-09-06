class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :category, :price, :is_active, :image, :image_url
end
