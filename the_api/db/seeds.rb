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

# Create some sample articles for the default user
articles_data = [
  {
    title: "The Power of Habit",
    content: "This article explores the science behind habits and how to change them."
  },
  {
    title: "Mindfulness in Everyday Life",
    content: "Discover how mindfulness can reduce stress and improve well-being."
  },
  {
    title: "The Art of Storytelling",
    content: "Learn the elements of a compelling story and how to craft your own."
  },
  # Add more article data as needed
]

articles_data.each do |article_data|
  user.articles.create!(article_data)
end
