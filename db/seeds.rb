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
  retries = 3
  begin
    response = HTTParty.get('https://dog.ceo/api/breeds/image/random')
    response.parsed_response['message']
  rescue SocketError => e
    retries -= 1
    if retries > 0
      sleep(1)
      retry
    else
      puts "Failed to fetch image after 3 attempts: #{e.message}"
      nil
    end
  end
end

# Seed breeds and sub_breeds from Dog CEO's Dog API
dog_ceo_data = fetch_dog_ceo_data

dog_ceo_data.each do |breed_name, sub_breeds|
  breed = Breed.find_or_create_by!(name: breed_name.capitalize)

  sub_breeds.each do |sub_breed_name|
    sub_breed = SubBreed.find_or_create_by!(name: sub_breed_name.capitalize, breed: breed)
    sub_breed.update(description: Faker::Lorem.paragraph)
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

  # Generate up to 4 images for each breed using Dog CEO's Dog API
  4.times do
    image_url = fetch_dog_image
    if image_url
      Image.create!(
        url: image_url,
        breed: breed
      )
    else
      puts "Skipping image creation for breed: #{breed_name} due to fetch failure"
    end
  end
end

# Generate fake owners using Faker
50.times do
  owner = Owner.create!(name: Faker::Name.name)

  # Associate each owner with 3-5 random breeds
  owner.breeds << Breed.order('RANDOM()').limit(5)
end

puts "Database has been seeded successfully!"
