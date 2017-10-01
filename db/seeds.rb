require "csv"

col, cat = nil, nil

file = Rails.root.join("seed", "data.csv")

CSV.foreach(file) do |row|
  col = Collection.find_or_create_by(name: row[2]) unless row[2] == col&.name
  cat = Category.find_or_create_by(name: row[3]) unless row[2] == cat&.name

  Badge.create(
    name: row[0],
    year: row[1],
    collection: col,
    category: cat,
    image: File.new(Rails.root.join("seed", "badge_images", row[4]))
  )
end

users = []

users << x = User.create(
  email: "me@mamamia.com",
  username: "joe",
  name: "joe",
  address: "123 platz place, somewhere",
  password_hash: BCrypt::Password.create("mamamia"),
  admin: true
)

users << User.create(
  email: "user@test.com",
  username: "testee",
  name: "joe",
  address: "123 platz place, somewhere",
  password_hash: BCrypt::Password.create("abc123"),
  admin: false
)

users << User.create(
  email: "joe@shmo.com",
  username: "joe",
  name: "joe",
  address: "123 platz place, somewhere",
  password_hash: BCrypt::Password.create("joeshmo"),
  admin: false
)
