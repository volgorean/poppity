class User < ApplicationRecord
  has_many :inventories
  has_many :badges, through: :inventories

  has_many :wishes
  has_many :wish_items, through: :wishes, source: :badge

  has_many :trades

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end
end
