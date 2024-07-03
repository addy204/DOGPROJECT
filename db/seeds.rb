# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'httparty'

# Fetch data from Dog CEO's Dog API
def fetch_dog_ceo_data
  response = HTTParty.get('https://dog.ceo/api/breeds/list/all')
  response.parsed_response['message']
end

# Fetch data from The Dog API
def fetch_dog_api_data(breed_name)
  api_key = 'live_qUKnbhCEfGGdVrUtSLjriz2sMxCk5qwfp1aJvA4rLbHROTfx0KgRUpmL54NYCoZW'
  response = HTTParty.get("https://api.thedogapi.com/v1/breeds/search?q=#{breed_name}", headers: { 'x-api-key' => api_key })
  response.parsed_response.first
end

# Fetch random dog images from Dog CEO's Dog API
def fetch_dog_image
  response = HTTParty.get('https://dog.ceo/api/breeds/image/random')
  response.parsed_response['message']
end

# Seed breeds and sub_breeds from Dog CEO's Dog API
dog_ceo_data = fetch_dog_ceo_data

dog_ceo_data.each do |breed_name, sub_breeds|
  breed = Breed.find_or_create_by!(name: breed_name.capitalize)

  sub_breeds.each do |sub_breed_name|
    SubBreed.find_or_create_by!(name: sub_breed_name.capitalize, breed: breed)
  end

  # Fetch breed details from The Dog API
  dog_api_data = fetch_dog_api_data(breed_name)
  if dog_api_data && dog_api_data['temperament'].present? && dog_api_data['life_span'].present? && dog_api_data['weight'].present? && dog_api_data['height'].present? && dog_api_data['image'].present?
    BreedDetail.find_or_create_by!(
      breed: breed,
      temperament: dog_api_data['temperament'],
      life_span: dog_api_data['life_span'],
      weight: "#{dog_api_data['weight']['imperial']} lbs",
      height: "#{dog_api_data['height']['imperial']} inches",
      image_url: dog_api_data['image']['url']
    )
  else
    puts "Skipping breed: #{breed_name} due to missing data"
  end
end

# Generate fake images for breeds using Dog CEO's Dog API
Breed.all.each do |breed|
  4.times do
    Image.create!(
      url: fetch_dog_image,
      breed: breed
    )
  end
end

# Generate fake owners using Faker
50.times do
  owner = Owner.create!(name: Faker::Name.name)

  # Associate each owner with 3-5 random breeds
  owner.breeds << Breed.order('RANDOM()').limit(5)
end

puts "Database has been seeded successfully!"
