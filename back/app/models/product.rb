require 'zlib'
require 'base64'

class Product < ApplicationRecord
  # Associações
  has_many :feedbacks, dependent: :destroy
  
  # Validações
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :product_value, presence: true
  validates :qty_available, presence: true
  validates :product_img, presence: true
  validates :rating_value, presence: true 
  
  before_validation :set_default_rating_value, on: :create

  after_save :update_average_rating, if: :feedbacks_changed?

  def set_default_rating_value
    self.rating_value ||= 0.0 
  end

  def compress_product_img(base64_image)
    compressed = Zlib::Deflate.deflate(base64_image)
    Base64.encode64(compressed)
  end

  def decompress_product_img(encoded_compressed_image)
    compressed = Base64.decode64(encoded_compressed_image)
    Zlib::Inflate.inflate(compressed)
  end

  def update_rating_value!
    self.rating_value = feedbacks.average(:rating_value) || 0.0
    save
  end
  private

  def feedbacks_changed?
    feedbacks.any? { |feedback| feedback.saved_changes? }
  end
end
