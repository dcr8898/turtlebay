class User < ActiveRecord::Base
  has_secure_password

  has_many :items, foreign_key: "seller_id"
  has_many :purchases, class_name: "Item", foreign_key: "buyer_id"
  has_many :bids, foreign_key: "bidder_id"

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }

  def bid_items
    Item.where(id: self.bids.select(:item_id).group(:item_id))
  end

  def to_param
    "#{id}-#{username.parameterize}"
  end

end
