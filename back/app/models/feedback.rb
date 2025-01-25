class Feedback < ApplicationRecord
  belongs_to :product
  belongs_to :user
  
  # Validações
  validates :rating_value, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 500 }
end
