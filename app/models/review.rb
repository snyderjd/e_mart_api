class Review < ApplicationRecord

  # Validations
  validates :user_id, :product_id, :title, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }

  # Associations
  belongs_to :user
  belongs_to :product

end