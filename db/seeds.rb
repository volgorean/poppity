def fake_name
  out = []

  out << ["Eland", "Meercat", "Penguin", "ladybird", "Gruffalo", "Reindeer", "Chocolate", "Rabbit", "Tiger"].sample
  out << ["Adventure", "Bedroom", "Birthday", "River", "Heard", "Train", "Ride", "Scientist", "School"].sample

  out.join(" ")
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

["Legoland", "Alton Towers", "Chester Zoo", "Folly Farm", "Hogwarts"].each do |name|
  Collection.create(name: name)
end

["pop badge", "collector bricks", "pin badges", "minifigures"].each do |name|
  Category.create(name: name)
end

cat_ids = Category.all.pluck(:id)

Collection.all.each do |c|
  (2012..2017).each do |year|
    rand(10).times do
      b = Badge.create(
        name: fake_name,
        year: year,
        category_id: cat_ids.sample,
        collection_id: c.id
      )

      users.each do |u|
        if rand(0..1) == 1
          u.wishes.create(badge: b)
        else
          u.inventories.create(badge: b, number: 1)
        end
      end
    end
  end
end
