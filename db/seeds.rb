require 'pexels'
require "json"
require "open-uri"

pex = Pexels::Client.new('sEpDeAZP9RRh5YnpiLUPLtyvufibCueYBpqUjOeVzxGbzPH9ZAsidXVh')

CITYS = ["Tokyo", "Sao Paulo", "Jakarta", "Delhi", "Seoul", "Shanghai", "Le Caire", "Bombay",
  "Canton", "Lagos", "New York", "Chongqing", "Pekin", "Mexico", "Moscou", "Osaka",
  "Bangkok", "Los Angeles", "Dacca", "Calcutta", "Karachi", "Teheran", "Buenos Aires", "Istanbul", "Hyderabad",
  "Gauteng", "Chengdu", "Londres", "Shantou", "Tianjin", "Quanzhou Xiamen",
  "Ho-Chi-Minh-Ville", "Surabaya", "Bangalore", "Paris", "Bagdad", "Chennai", "Xian",
  "Rio de Janeiro", "Kinshasa", "Shenzhen", "Lahore", "Lima", "Nagoya", "Bogota", "Wuhan", "Suzhou", "Rhin-Ruhr",
  "Hangzhou", "Chicago", "Washington", "San Francisco", "San Jose", "Taipei", "Luanda", "Bandung", "Rangoon", "Khartoum",
  "Nankin", "Dongguan", "Amsterdam", "Shenyang", "Boston", "Milan",
  "Kuala Lumpur", "Singapour", "Ahmedabad", "Dallas", "Busan", "Islamabad Rawalpindi", "Faisalabad", "Alger",
  "Nairobi", "Hanoi", "Santiago", "Hong Kong", "Houston", "Semarang", "Philadelphie", "Riyad", "Miami", "Atlanta",
  "Surate", "Toronto", "Madrid", "Qingdao", "Saint Petersbourg", "Pune", "Amman", "Colombo", "Surakarta",
  "Belo Horizonte", "Ibadan", "Zhengzhou", "Detroit", "Ankara", "Guatemala", "Dubai"]

puts "Starting seed"

Trip.destroy_all
User.destroy_all
Message.destroy_all
Destination.destroy_all
TripDestination.destroy_all


pex = Pexels::Client.new('sEpDeAZP9RRh5YnpiLUPLtyvufibCueYBpqUjOeVzxGbzPH9ZAsidXVh')


rand(20..30).times do |i|
  if i.zero?
    User.create({ email: "test@test.test", password: "testtest", first_name: "Audran", last_name: "Pillard" })
  else
    User.create({ email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name })
  end
end

rand(20..30).times do |j|
  city = CITYS.sample
  picture = []
  # picture = pex.photos.search(city, per_page: 1).photos
  if picture.length == 1
    maphoto = picture.first.src["large"]
  else
    maphoto = "https://www.deutschland.de/sites/default/files/styles/image_container/public/media/image/living-in-germany-city-frankfurt-skyline.jpg?itok=ZSTPGApy"
  end
  puts maphoto
  planner = User.all.sample
  trip = Trip.create({ title: Faker::Adjective.positive.capitalize + " trip at " + city,
    image_url: maphoto,
    comment: Faker::Lorem.paragraph,
    budget: rand(100..1000),
    city: city,
    planner: planner,
    tripper: planner
    })
  puts trip.save!

  rand(0..2).times do |k|
    copied_trip = trip.dup
    copied_trip.trip_id = trip.id
    # puts copied_trip.trip
    puts "*end* "*10
    copied_trip.tripper = User.where.not(id: planner.id).sample
    copied_trip.save
  end
end


Trip.all.each do |trip|


  rand(2..10).times do
    Message.create({ content:Faker::Lorem.sentence, trip: trip, user: [trip.planner, trip.tripper].sample })
  end

  url = "http://overpass-api.de/api/interpreter?data=[out:json];area[name=\"#{trip.city}\"]->.searchArea;node[amenity=restaurant](area.searchArea);out;"
  JSON.parse(URI.open(url).read)["elements"].each_with_index do |a, n|
    break if n >= 10
    add = "Not found"
    add = "#{a["tags"]["addr:housenumber"]} #{a["tags"]["addr:street"]}" if a["tags"].key?("addr:housenumber") && a["tags"].key?("addr:street")
    lat = a["lat"] if a.key?("lat")
    lon = a["lon"] if a.key?("lon")

    destination = Destination.create({
      longitude: lon,
      latitude: lat,
      address: add,
      description: Faker::Lorem.sentence,
      position: n
      })
      trip.destinations << destination
      trip.save
  end

end

puts "Creating one real example"

user1 = User.create(
  first_name: "Jane",
  last_name: "Smith",
  email: "jane@example.com",
  password: "password"
)

trip1 = Trip.create(
  title: "Super cute romantic trip in Italy",
  city: "Rome, Florence, Venice",
  image_url: "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/0e/c8.jpg",
  comment: "Embarking on an Italian escapade for a romantic journey. Our path unveils hidden treasures at every stop. In Rome, the Eternal City, each monument narrates a timeless love story. Florence, with its sublime art, leaves an artistic imprint on our hearts. And finally, the winding canals of Venice mirror our love in their tranquil waters. This unforgettable voyage through the charm of Italy will forever be etched in our story.",
  planner_id: user1.id,
  tripper_id: user1.id
)

destination_italy1 = Destination.create(
  address: "Rome, Italy",
  latitude: 41.9028,
  longitude: 12.4964,
  position: 1,
  description: "Explore the captivating history of Rome as you stand before the ancient Colosseum and wander through the ruins of the Roman Forum. Savor traditional pasta dishes in quaint trattorias and make a wish at the iconic Trevi Fountain, surrounded by the city's timeless beauty."
)

destination_italy2 = Destination.create(
  address: "Florence, Italy",
  latitude: 43.7696,
  longitude: 11.2558,
  position: 2,
  description: "Indulge in the artistic treasures of Florence, where Michelangelo's David and Botticelli's Birth of Venus reside. Stroll along the Arno River, cross the iconic Ponte Vecchio, and savor gelato in bustling piazzas. Florence's charm and creativity will leave you enchanted."
)

destination_italy3 = Destination.create(
  address: "Venice, Italy",
  latitude: 45.4408,
  longitude: 12.3155,
  position: 3,
  description: "Embark on a romantic journey through the enchanting canals of Venice, serenaded by the gentle lapping of water against historic palaces. Discover hidden squares, indulge in delectable seafood, and visit the glassmaking island of Murano, where artistry and beauty intertwine."
)

trip_destinations = TripDestination.create(
  trip: trip1,
  destination: destination_italy1
)

trip_destinations = TripDestination.create(
  trip: trip1,
  destination: destination_italy2
)

trip_destinations = TripDestination.create(
  trip: trip1,
  destination: destination_italy3
)

puts "Done"
