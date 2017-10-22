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

  def pay!
    self.update_columns(is_paid: true)
  end

  def set_paymeny_with_method(method)
    self.update_columns(payment_method: method)
  end
end
