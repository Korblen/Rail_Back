# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# frozen_string_literal: true

# Create a default user if none exists
default_email = "user@example.com"
default_password = "password"

unless User.find_by(email: default_email)
  User.create!(email: default_email, password: default_password) 
end

# Get the default user
user = User.find_by(email: default_email)
uuser = User.all

# Create some sample articles for the default user
uuser.each do |user|
  30.times do |i|
    user.articles.create!(title: "Article #{i}", content: "Content for article #{i}")
  end
end
