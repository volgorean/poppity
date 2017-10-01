class Badge < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :category, counter_cache: true
  belongs_to :collection, counter_cache: true

  has_many :inventories, dependent: :destroy
  has_many :users, through: :inventories

  has_many :wishes, dependent: :destroy
  has_many :wishers, through: :wishes, source: :user

  has_many :trade_badges, dependent: :destroy
  has_many :trades, through: :trade_badges

  has_attached_file :image,
    styles: {thumb: "50x50>" },
    url: "/sources/:hash.:extension",
    hash_secret: "ThisIsntProtectingAnythingJustWantADirectLink",
    default_url: "/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
