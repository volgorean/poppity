class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  
  has_many :badges

  has_attached_file :image,
    styles: {thumb: "50x50>" },
    url: "/sources/:hash.:extension",
    hash_secret: "ThisIsntProtectingAnythingJustWantADirectLink",
    default_url: "/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
