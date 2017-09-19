class User < ApplicationRecord
  has_many :inventories
  has_many :badges, through: :inventories

  has_many :wishes
  has_many :wish_items, through: :wishes, source: :badge

  validates :email, presence: true, uniqueness: {message: "This email is already in use."}
  validates :username, presence: true, uniqueness: {message: "This username is already in use."}

  validates :name, presence: true
  validates :address, presence: true

  def trades
    Trade.where("a_id = ? OR b_id = ?", self.id, self.id)
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end
end
