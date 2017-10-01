class User < ApplicationRecord
  extend FriendlyId

  friendly_id :username, use: :slugged

  has_many :inventories, dependent: :destroy
  has_many :badges, through: :inventories

  has_many :wishes, dependent: :destroy
  has_many :wish_items, through: :wishes, source: :badge

  has_many :trade_badges, dependent: :destroy

  validates :email, presence: true, uniqueness: {message: "This email is already in use."}
  validates :username, presence: true, uniqueness: {message: "This username is already in use."}

  validates :name, presence: true
  validates :address, presence: true

  after_destroy :destroy_all_trades

  def trades
    Trade.where("a_id = ? OR b_id = ?", self.id, self.id)
  end

  def destroy_all_trades
    self.trades.destroy_all
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end
end
