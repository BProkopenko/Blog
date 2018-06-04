# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin
User.create!(name: "Vasya Pupkin",
             email: "vasvas@mail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Moderator
User.create!(name: "petya Pupkin",
             email: "pet@mail.com",
             password: "123456",
             password_confirmation: "123456",
             moder: true,
             activated: true,
             activated_at: Time.zone.now)

# User
User.create!(name: "vova Pupkin",
             email: "vov@mail.com",
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

# Topics
Topic.create(theme: "Science",
             description: "About science",
             user_id: 1)
Topic.create(theme: "Society",
             description: "Social questions",
             user_id: 1)
Topic.create(theme: "Movies",
             description: "About movies",
             user_id: 1)

# Fake users
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@mail.org"
	password = "password"
	User.create!(name: name,
	             email: email,
	             password: password,
	             password_confirmation: password,
	             activated: true,
	             activated_at: Time.zone.now)
end

# Posts
users = User.order(:created_at).take(6)
50.times do
	title = Faker::Lorem.sentence(2, false, 2 )
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.posts.create!(content: content, title: title, topic_id: rand(1..3)) }
end

# add comments to posts
posts = Post.order(:created_at).take(300)
50.times do
	body = Faker::Lorem.sentence(2, false, 2 )
	posts.each { |post| post.comments.create!(body: body, user: User.find_by(id: rand(1..40)) )}
end
