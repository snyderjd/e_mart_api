class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :reviewer_name, :product_id, :rating, :title, :body, :created_at, :updated_at
end

def reviewer_name
  "#{self.user.first_name} #{self.user.last_name}"
end