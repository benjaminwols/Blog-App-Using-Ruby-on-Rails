# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

require 'faker'

users = 5.times.map do
  User.create(
    email: "#{Faker::Name.first_name.downcase}@gmail.com",
    password: "Welkom01!"
  )
end

users.each do |user|
  post = Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number:2).join("\n"),
    status: Comment::VALID_STATUSES.sample
  )

  5.times do
    post.comments.create(
      author: Faker::Book.author,
      body: Faker::Lorem.sentences(number: 2).join("\n"),
      status: Comment::VALID_STATUSES.sample
    )
  end
end
