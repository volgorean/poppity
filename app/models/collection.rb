class Collection < ApplicationRecord
  has_many :badges

  has_attached_file :image,
    styles: {thumb: "50x50>" },
    url: "/system/:hash.:extension",
    hash_secret: "babbityRabbity",
    default_url: "/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
