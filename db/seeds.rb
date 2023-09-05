require 'pexels'
require "json"
require "open-uri"

pex = Pexels::Client.new(ENV["PEXELS_API_KEY"])

CITYS = ["Bangkok", "Paris", "London", "Dubai", "Singapore", "Kuala Lumpur", "New York City", "Istanbul", "Tokyo",
  "Seoul", "Antalya", "Phuket", "Mecca", "Pattaya", "Milan", "Barcelona", "Rome", "Osaka", "Taipei", "Shanghai",
  "Vienna", "Amsterdam", "Los Angeles", "Madrid", "Guangzhou", "Prague", "Miami", "Munich", "Las Vegas", "Dublin",
  "Riyadh", "Berlin", "Toronto", "Venice", "Sydney", "Vienna", "Hong Kong", "Johannesburg", "Edinburgh", "Marrakech",
  "Dubrovnik", "Helsinki", "Copenhagen", "Stockholm", "Budapest", "Warsaw", "Krakow", "Zurich", "Athens", "Nairobi",
  "Abu Dhabi", "Delhi", "Mumbai", "Jaipur", "Bangalore", "Kolkata", "Bali", "Ho Chi Minh City", "Hanoi", "Manila",
  "Lima", "Buenos Aires", "Sao Paulo", "Rio de Janeiro", "Cairo", "Alexandria", "Cape Town", "Nairobi", "Amman",
  "Jerusalem", "Toronto", "Vancouver", "Montreal", "Calgary", "Quebec City", "Edmonton", "Ottawa", "Havana",
  "Santiago de Cuba", "Bogota", "Medellin", "Cancun", "Playa del Carmen", "Mexico City", "Guadalajara", "Monterrey",
  "Moscow", "St. Petersburg", "Kyiv", "Odessa", "Kazan", "Sochi", "Yekaterinburg", "Novosibirsk", "Irkutsk",
  "Vladivostok", "Krasnoyarsk", "Yerevan", "Tbilisi", "Baku", "Kiev", "Minsk", "Warsaw", "Prague"]


  STYLES = ["cultural", "adventure", "romantic", "gastronomic", "ecotourism", "luxury", "accessible", "party", "humanitarian"]
  DESTINATIONS_CRITERES = {
    cultural: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    adventure: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    romantic: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    gastronomic: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    ecotourism: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    luxury: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    accessible: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    party: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ],
    humanitarian: [
      "tourism=attraction",
      "tourism=artwork",
      "tourism=gallery"
    ]
  }


def create_destination(trip, style)
  found = false
  # DESTINATIONS_CRITERES.keys.each do |style|
  cptttl = 0
  DESTINATIONS_CRITERES[style.to_sym].each do |categories|
    url = "http://overpass-api.de/api/interpreter?data=[out:json];area[name=\"#{trip.city}\"]->.searchArea;node[#{categories}](area.searchArea);out;"
    cpt = 0
    JSON.parse(URI.open(url).read)["elements"].each_with_index do |a, n|
      cpt = n
      cptttl += 1
      break if n >= 10 || !a["tags"].key?("name")#|| !a["tags"].key?("addr:housenumber") || !a["tags"].key?("addr:street")
      found = true
      # puts "#{n} #{a["tags"]["name"]} '#{a["tags"]["addr:housenumber"]} #{a["tags"]["addr:street"]}'"
      lat = a["lat"] if a.key?("lat")
      lon = a["lon"] if a.key?("lon")

      trip.destinations.new({
        title: a["tags"]["name"],
        longitude: lon,
        latitude: lat,
        address: "is_coming.....", #{a["tags"]["addr:housenumber"]} #{a["tags"]["addr:street"]}"
        description: Faker::Lorem.sentence,
        position: cptttl
      })
    end
    puts "- #{cpt} lieu(x) #{categories}" if cpt != 0
  end

  found
end


puts "Starting seed"

Trip.destroy_all
User.destroy_all
Message.destroy_all
Destination.destroy_all
TripDestination.destroy_all

pex = Pexels::Client.new('sEpDeAZP9RRh5YnpiLUPLtyvufibCueYBpqUjOeVzxGbzPH9ZAsidXVh')

IMAGE_URL = [
  "https://avatars.githubusercontent.com/u/102687903?v=4",
  "https://avatars.githubusercontent.com/u/60078137?v=4",
  "https://avatars.githubusercontent.com/u/101594582?v=4",
  "https://avatars.githubusercontent.com/u/139124612?v=4",
  "https://avatars.githubusercontent.com/u/138495721?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688992728/dwty0kmrxptymirqocjk.jpg",
  "https://avatars.githubusercontent.com/u/135238187?v=4",
  "https://avatars.githubusercontent.com/u/136320274?v=4",
  "https://avatars.githubusercontent.com/u/139125894?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688993845/fvpb8lfyosqeivzds7ez.jpg",
  "https://avatars.githubusercontent.com/u/44208500?v=4",
  "https://avatars.githubusercontent.com/u/139124191?v=4",
  "https://avatars.githubusercontent.com/u/118887314?v=4",
  "https://avatars.githubusercontent.com/u/120410801?v=4",
  "https://avatars.githubusercontent.com/u/102727596?v=4",
  "https://avatars.githubusercontent.com/u/107953331?v=4",
  "https://avatars.githubusercontent.com/u/136184385?v=4",
  "https://avatars.githubusercontent.com/u/139124726?v=4",
  "https://avatars.githubusercontent.com/u/135331205?v=4",
  "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688995034/okfhhgjkc71sqo7mpqpk.jpg",
  "https://avatars.githubusercontent.com/u/139124434?v=4"
]

rand(20..30).times do |i|
  if i.zero?
    User.create({ email: "test@test.test", password: "testtest", first_name: "Audran", last_name: "Pillard", image_url: "https://avatars.githubusercontent.com/u/135331205?v=4" })
  else
    User.create({ email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, image_url: IMAGE_URL.sample })
  end
end

rand(10..20).times do |j|
  city = CITYS.sample

# CITYS.each_with_index do |city, j|

  style = DESTINATIONS_CRITERES.keys.sample.to_s
  picture = []
  picture = pex.photos.search(city, per_page: 1).photos
  if picture.length == 1
    maphoto = picture.first.src["large"]
  else
    maphoto = "https://www.deutschland.de/sites/default/files/styles/image_container/public/media/image/living-in-germany-city-frankfurt-skyline.jpg?itok=ZSTPGApy"
  end
  if j.zero?
    planner = User.first
  else
    planner = User.all.sample
  end
  trip = Trip.new({
    title: Faker::Adjective.positive.capitalize + " trip at " + city,
    image_url: maphoto,
    comment: Faker::Lorem.paragraph,
    budget: rand(100..10000),
    city: city,
    planner: planner,
    tripper: planner,
    style: style
  })


  puts ""
  puts trip.city.upcase
  if create_destination(trip, style)
    trip.save
    rand(0..3).times do |k|
      copied_trip = trip.dup
      copied_trip.trip_id = trip.id
      copied_trip.destinations = trip.destinations
      copied_trip.tripper = User.where.not(id: planner.id).sample
      copied_trip.save
    end
  end
end


Trip.all.each do |trip|
  if trip.planner != trip.tripper
    rand(2..10).times do
      trip.messages.create({ content:Faker::Lorem.sentence, user: [trip.planner, trip.tripper].sample })
    end
  end
end

puts "Creating one real example"


user1 = User.create(
  first_name: "Jane",
  last_name: "Smith",
  email: "jane@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/107953331?v=4"
)

trip1 = Trip.create(
  title: "Super cute romantic trip in Italy",
  city: "Rome, Florence, Venice",
  image_url: "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/0e/c8.jpg",
  comment: "Embarking on an Italian escapade for a romantic journey. Our path unveils hidden treasures at every stop. In Rome, the Eternal City, each monument narrates a timeless love story. Florence, with its sublime art, leaves an artistic imprint on our hearts. And finally, the winding canals of Venice mirror our love in their tranquil waters. This unforgettable voyage through the charm of Italy will forever be etched in our story.",
  planner_id: user1.id,
  tripper_id: user1.id,
  style: "romantic"
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
