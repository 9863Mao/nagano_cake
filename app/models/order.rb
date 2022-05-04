class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum adress: [ :"ご自身の住所", :"登録先住所から選択", :"新しいお届け先"]
  enum status: { waiting_for_payment: 0, payment_confirmation: 1, now_making: 2, preparing_to_ship: 3, shipped: 4 }
  def total_price
    item.add_tax_price * amount
  end
end