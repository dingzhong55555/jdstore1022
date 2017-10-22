class Order < ApplicationRecord
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shopping_name, presence: true
  validates :shopping_address, presence: true
  before_create :generate_token


  belongs_to :user
  has_many :product_lists

  def generate_token
    self.token = SecureRandom.uuid
  end
end
