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

CITYS.each do |u|
  puts ""
  puts u
  puts pex.photos.search(u, per_page: 1).photos.length
  puts pex.photos.search(u, per_page: 1).photos.first.src["large"]
end

# rand(20..30).times do |i|
#   if i.zero?
#     User.create({ email: "test@test.test", password: "testtest", first_name: "Audran", last_name: "Pillard" })
#   else
#     User.create({ email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name })
#   end
# end

# rand(20..30).times do |j|
#   city = CITYS.sample
#   if pex.photos.search(city, per_page: 1).photos.length
#     puts city
#     maphoto = pex.photos.search(city, per_page: 1).photos.first.src["large"]
#   else
#     maphoto = ""
#   end
#   tripper = User.all.sample

#   a = Trip.new({ title: Faker::Adjective.positive + " trip at " + city,
#     image_url: maphoto,
#     comment: Faker::Lorem.paragraph,
#     tripper: tripper,
#     planner: User.where.not(id: tripper.id).sample })
#   a.save

# end









puts "Done"


# create_table "trips", force: :cascade do |t|
#   t.bigint "planner_id"
#   t.bigint "tripper_id"
#   t.string "title"
#   t.string "image_url"
#   t.text "comment"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "trip_id"
#   t.index ["planner_id"], name: "index_trips_on_planner_id"
#   t.index ["trip_id"], name: "index_trips_on_trip_id"
#   t.index ["tripper_id"], name: "index_trips_on_tripper_id"
# end


# create_table "destinations", force: :cascade do |t|
#   t.integer "longitude"
#   t.integer "latitude"
#   t.string "address"
#   t.string "description"
#   t.integer "position"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

# create_table "messages", force: :cascade do |t|
#   t.string "content"
#   t.bigint "trip_id", null: false
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["trip_id"], name: "index_messages_on_trip_id"
#   t.index ["user_id"], name: "index_messages_on_user_id"
# end
