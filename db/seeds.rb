require 'pexels'
pex = Pexels::Client.new('sEpDeAZP9RRh5YnpiLUPLtyvufibCueYBpqUjOeVzxGbzPH9ZAsidXVh')

CITYS = ["Tokyo", "Sao Paulo", "Jakarta", "Delhi", "Séoul", "Shanghai", "Le Caire", "Bombay (Mumbai)",
  "Canton (Guangzhou)", "Lagos", "New York", "Chongqing", "Pékin (Beijing)", "Mexico", "Moscou", "Osaka - Kyoto - Kobe",
  "Bangkok", "Los Angeles", "Dacca (Dhaka)", "Calcutta", "Karachi", "Téhéran", "Buenos Aires", "Istanbul", "Hyderabad",
  "Gauteng (Johannesburg - Pretoria)", "Chengdu", "Londres", "Shantou", "Tianjin", "Quanzhou - Xiamen",
  "Hô-Chi-Minh-Ville (Saïgon)", "Surabaya", "Bangalore (Bengaluru)", "Paris", "Bagdad", "Chennai (Madras)", "Xian",
  "Rio de Janeiro", "Kinshasa", "Shenzhen", "Lahore", "Lima", "Nagoya", "Bogota", "Wuhan", "Suzhou", "Rhin-Ruhr",
  "Hangzhou", "Chicago", "Washington", "San Francisco - San José", "Taipei", "Luanda", "Bandung", "Rangoon", "Khartoum",
  "Nankin (Nanjing)", "Dongguan", "Randstad (Amsterdam - La Haye - Rotterdam)", "Shenyang", "Boston", "Milan",
  "Kuala Lumpur", "Singapour", "Ahmedabad", "Dallas", "Busan", "Islamabad - Rawalpindi", "Faisalabad", "Alger",
  "Nairobi", "Hanoï", "Santiago", "Hong Kong", "Houston", "Semarang", "Philadelphie", "Riyad", "Miami", "Atlanta",
  "Surate", "Toronto", "Madrid", "Qingdao", "Saint-Pétersbourg", "Pune", "Amman", "Colombo", "Surakarta",
  "Belo Horizonte", "Ibadan", "Zhengzhou", "Détroit", "Ankara", "Guatemala", "Dubaï"]



puts "Starting seed"

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

  # rand(2..10).times do |l|
  #   Destination.create({
  #     longitude:,
  #     latitude:,
  #     address:,
  #     description:,
  #     position:
  #     })
  # end


end


puts "Done"
