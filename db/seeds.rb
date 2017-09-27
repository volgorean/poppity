require "csv"

col, cat = nil, nil

file = File.expand_path File.join(File.dirname(__FILE__), "seeds.csv")

CSV.foreach(file) do |row|
  col = Collection.find_or_create_by(name: row[2]) unless row[2] == col&.name
  cat = Category.find_or_create_by(name: row[3]) unless row[2] == cat&.name

  image = File.open(File.join(File.dirname(__FILE__), row[4]))

  Badge.create(
    name: row[0],
    year: row[1],
    collection: col,
    category: cat,
    image: image.read,
    image_type: "image/jpeg"
  )
end

users = []

users << User.create(
  email: "me@mamamia.com",
  username: "admin",
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
