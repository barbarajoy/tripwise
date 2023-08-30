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



Destination.destroy_all
Message.destroy_all
Trip.destroy_all
User.destroy_all


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
  picture = pex.photos.search(city, per_page: 1).photos
  if picture.length == 1
    maphoto = picture.first.src["large"]
  else
    maphoto = "https://www.deutschland.de/sites/default/files/styles/image_container/public/media/image/living-in-germany-city-frankfurt-skyline.jpg?itok=ZSTPGApy"
  end
  tripper = User.all.sample
  trip = Trip.create({ title: Faker::Adjective.positive.capitalize + " trip at " + city,
    image_url: maphoto,
    comment: Faker::Lorem.paragraph,
    tripper: tripper,
    planner: User.where.not(id: tripper.id).sample })


  rand(2..10).times do |k|
    Message.create({ content:Faker::Lorem.sentence, trip: trip, user: [trip.planner, trip.tripper].sample })
  end

  url = "http://overpass-api.de/api/interpreter?data=[out:json];area[name=\"#{city}\"]->.searchArea;node[amenity=restaurant](area.searchArea);out;"

  JSON.parse(URI.open(url).read)["elements"].each_with_index do |a, i|
    break if i >= 10
    add = "pas trouvé"
    add = "#{a["tags"]["addr:housenumber"]} #{a["tags"]["addr:street"]}" if a["tags"].key?("addr:housenumber") && a["tags"].key?("addr:street")
    lat = a["lat"] if a.key?("lat")
    lon = a["lon"] if a.key?("lon")

    Destination.create({
      longitude: lon,
      latitude: lat,
      address: add,
      description: "a",
      position: i,
      trip: trip
      }).save
  end


end


puts "Done"
