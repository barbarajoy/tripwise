require 'pexels'
require "json"
require "open-uri"
require 'cgi'

pex = Pexels::Client.new(ENV["PEXELS_API_KEY"])

CITYS = ["Rome", "Venise", "Florence", "Bangkok", "Paris", "London", "Dubai", "Singapore", "Kuala Lumpur",
  "Seoul", "Antalya", "Phuket", "Mecca", "Pattaya", "Milan", "Barcelona", "Rome", "Osaka", "Taipei", "Shanghai",
  "Vienna", "Amsterdam", "Los Angeles", "Madrid", "Guangzhou", "Prague", "Miami", "Munich", "Las Vegas", "Dublin",
  "Riyadh", "Berlin", "Toronto", "Venice", "Sydney", "Vienna", "Hong Kong", "Johannesburg", "Edinburgh", "Marrakech",
  "Dubrovnik", "Helsinki", "Copenhagen", "Stockholm", "Budapest", "Warsaw", "Krakow", "Zurich", "Athens", "Nairobi",
  "Abu Dhabi", "Delhi", "Mumbai", "Jaipur", "Bangalore", "Kolkata", "Bali", "Ho Chi Minh City", "Hanoi", "Manila",
  "Lima", "Buenos Aires", "Sao Paulo", "Rio de Janeiro", "Cairo", "Alexandria", "Cape Town", "Nairobi", "Amman",
  "Jerusalem", "Toronto", "Vancouver", "Montreal", "Calgary", "Quebec City", "Edmonton", "Ottawa", "Havana",
  "Santiago de Cuba", "Bogota", "Medellin", "Cancun", "Playa del Carmen", "Mexico City", "Guadalajara", "Monterrey",
  "Moscow", "St. Petersburg", "Kyiv", "Odessa", "Kazan", "Sochi", "Yekaterinburg", "Novosibirsk", "Irkutsk",
  "Vladivostok", "Krasnoyarsk", "Yerevan", "Tbilisi", "Baku", "Kiev", "Minsk", "Warsaw", "Prague", "New York City",
  "Istanbul", "Tokyo"]


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


puts "Starting seed"

Trip.destroy_all
User.destroy_all
Message.destroy_all
Destination.destroy_all
TripDestination.destroy_all

pex = Pexels::Client.new('sEpDeAZP9RRh5YnpiLUPLtyvufibCueYBpqUjOeVzxGbzPH9ZAsidXVh')
cpt_first_user = 0

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
    User.create({ email: "test@test.test", password: "testtest", first_name: "Adel", last_name: "Martin", image_url: "https://avatars.githubusercontent.com/u/135331205?v=4" })
  else
    User.create({ email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, image_url: IMAGE_URL.sample })
  end
end

cpt_trip = 0
cpt_trip_tentative = 0
while cpt_trip < 5
  # rand(20..30).times do |j|
  # CITYS.each_with_index do |city, j|
  city = CITYS[cpt_trip_tentative]
  cpt_trip_tentative += 1

  if cpt_trip < 4
    style = "romantic"
  else
    style = DESTINATIONS_CRITERES.keys.sample.to_s
  end
  picture = []
  # picture = pex.photos.search(city, per_page: 2).photos
  if picture.length > 0
    maphoto = picture.sample.src["large"]
  else
    maphoto = "https://www.deutschland.de/sites/default/files/styles/image_container/public/media/image/living-in-germany-city-frankfurt-skyline.jpg?itok=ZSTPGApy"
  end
  if cpt_trip.zero?
    planner = User.first
  else
    planner = User.all.sample
  end
  if cpt_trip == 0
    comment = "commentaire rome"
  elsif cpt_trip == 1
    comment = "commentaire venise"
  elsif cpt_trip == 2
    comment = "commentaire florence"
  else
    comment = "commentaire sample"
  end


  trip = Trip.new({
    title: Faker::Adjective.positive.capitalize + " trip at " + city,
    image_url: maphoto,
    comment: comment,
    budget: rand(100..1000),
    city: city,
    planner: planner,
    tripper: planner,
    style: style
  })


  found = true
  cptttl = 8
  if cpt_trip == 0
    # Colisée de Rome
    destination = Destination.create!({
      title: "Colisée de Rome",
      latitude: 41.890210,
      longitude: 12.492231,
      address: "Piazza del Colosseo, 1, 00184 Roma RM, Italy",
      description: "Le Colisée est un amphithéâtre romain antique situé dans le centre de Rome. C'est l'un des monuments les plus emblématiques de la Rome antique et un site touristique incontournable."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Basilique Saint-Pierre
    destination = Destination.create!({
      title: "Basilique Saint-Pierre",
      latitude: 41.902240,
      longitude: 12.453650,
      address: "Piazza San Pietro, 00120 Città del Vaticano",
      description: "La basilique Saint-Pierre est l'une des plus grandes églises du monde et un important site religieux situé dans la Cité du Vatican. Elle est renommée pour son architecture majestueuse et abrite de nombreuses œuvres d'art célèbres."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Fontaine de Trevi
    destination = Destination.create!({
      title: "Fontaine de Trevi",
      latitude: 41.900933,
      longitude: 12.483265,
      address: "Piazza di Trevi, 00187 Roma RM, Italy",
      description: "La Fontaine de Trevi est l'une des fontaines les plus célèbres du monde. Les visiteurs jettent traditionnellement une pièce de monnaie dans la fontaine pour s'assurer un retour à Rome."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Le Panthéon
    destination = Destination.create!({
      title: "Le Panthéon",
      latitude: 41.898615,
      longitude: 12.476833,
      address: "Piazza della Rotonda, 00186 Roma RM, Italy",
      description: "Le Panthéon est un temple antique romain bien préservé qui est aujourd'hui une église. Il est célèbre pour son impressionnante coupole et son architecture remarquable."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Galerie Borghèse
    destination = Destination.create!({
      title: "Galerie Borghèse",
      latitude: 41.914250,
      longitude: 12.492389,
      address: "Piazzale Scipione Borghese, 5, 00197 Roma RM, Italy",
      description: "La Galerie Borghèse est un musée abritant une impressionnante collection d'œuvres d'art, notamment des sculptures de Bernin, des peintures de Caravage et de Raphaël, ainsi que des antiquités romaines."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Place d'Espagne
    destination = Destination.create!({
      title: "Place d'Espagne",
      latitude: 41.905694,
      longitude: 12.483732,
      address: "Piazza di Spagna, 00187 Roma RM, Italy",
      description: "La Place d'Espagne est une place célèbre de Rome, connue pour son escalier monumental, l'escalier de la Trinité-des-Monts, et la Fontaine de la Barcaccia de Bernin."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Le Forum romain
    destination = Destination.create!({
      title: "Le Forum romain",
      latitude: 41.892480,
      longitude: 12.485396,
      address: "Via della Salara Vecchia, 5/6, 00186 Roma RM, Italy",
      description: "Le Forum romain était le centre politique, religieux et commercial de la Rome antique. Aujourd'hui en ruines, il offre un aperçu fascinant de l'histoire romaine."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Musées du Vatican
    destination = Destination.create!({
      title: "Musées du Vatican",
      latitude: 41.906188,
      longitude: 12.453639,
      address: "Viale Vaticano, 00165 Città del Vaticano",
      description: "Les Musées du Vatican abritent une vaste collection d'art et d'antiquités, notamment la Chapelle Sixtine, célèbre pour ses fresques de Michel-Ange."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )
  elsif cpt_trip == 1
    # Place Saint-Marc
    destination = Destination.create!({
      title: "Place Saint-Marc",
      latitude: 45.434190,
      longitude: 12.338780,
      address: "Piazza San Marco, 30100 Venezia VE, Italy",
      description: "La Place Saint-Marc est la place principale de Venise et l'un des centres historiques et culturels les plus importants de la ville. Elle est célèbre pour la Basilique Saint-Marc, la Tour de l'Horloge et le Palais des Doges."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Pont du Rialto
    destination = Destination.create!({
      title: "Pont du Rialto",
      latitude: 45.438682,
      longitude: 12.335020,
      address: "Ponte di Rialto, 30100 Venezia VE, Italy",
      description: "Le Pont du Rialto est l'un des ponts les plus emblématiques de Venise. Il enjambe le Grand Canal et est entouré de boutiques et de marchés."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Palais des Doges
    destination = Destination.create!({
      title: "Palais des Doges",
      latitude: 45.434334,
      longitude: 12.339266,
      address: "Piazza San Marco, 1, 30124 Venezia VE, Italy",
      description: "Le Palais des Doges est un palais vénitien magnifique qui servait de résidence officielle des doges de Venise. Aujourd'hui, il abrite un musée et est célèbre pour son architecture et ses œuvres d'art."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Île de Burano
    destination = Destination.create!({
      title: "Île de Burano",
      latitude: 45.485878,
      longitude: 12.416548,
      address: "Burano, 30142 Venezia VE, Italy",
      description: "L'île de Burano est célèbre pour ses maisons colorées et ses dentelles artisanales. C'est un endroit pittoresque pour se promener et découvrir la culture locale."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Île de Murano
    destination = Destination.create!({
      title: "Île de Murano",
      latitude: 45.457806,
      longitude: 12.355586,
      address: "Murano, 30141 Venezia VE, Italy",
      description: "L'île de Murano est renommée pour son artisanat du verre, en particulier pour ses souffleurs de verre talentueux. Vous pouvez visiter les ateliers de verre et découvrir l'art du soufflage de verre."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Pont des Soupirs
    destination = Destination.create!({
      title: "Pont des Soupirs",
      latitude: 45.434825,
      longitude: 12.340479,
      address: "Rio di Palazzo, 30100 Venezia VE, Italy",
      description: "Le Pont des Soupirs est un pont couvert qui relie le Palais des Doges aux prisons de Venise. Son nom provient de la légende selon laquelle les prisonniers soupiraient en passant par le pont en voyant Venise pour la dernière fois."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Île de Giudecca
    destination = Destination.create!({
      title: "Île de Giudecca",
      latitude: 45.4260821,
      longitude: 12.3182622,
      address: "Giudecca, 30100 Venezia VE, Italy",
      description: "L'île de Giudecca offre une vue panoramique sur Venise et est un lieu paisible pour échapper à l'agitation de la ville. Vous y trouverez des églises historiques et une atmosphère authentique."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Musée Guggenheim de Venise
    destination = Destination.create!({
      title: "Musée Guggenheim de Venise",
      latitude: 45.430876,
      longitude: 12.332588,
      address: "Dorsoduro, 701-704, 30123 Venezia VE, Italy",
      description: "Le Musée Guggenheim de Venise abrite une collection d'art moderne et contemporain dans un palais vénitien historique. Il présente des œuvres d'artistes renommés du 20e siècle."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )
  elsif cpt_trip == 2
    # Galerie des Offices (Galleria degli Uffizi)
    destination = Destination.create!({
      title: "Galerie des Offices",
      latitude: 43.769562,
      longitude: 11.255814,
      address: "Piazzale degli Uffizi, 6, 50122 Firenze FI, Italy",
      description: "La Galerie des Offices est l'un des musées d'art les plus célèbres au monde, abritant une vaste collection de chefs-d'œuvre de la Renaissance italienne, notamment des œuvres de Botticelli, Michel-Ange et Léonard de Vinci."
    })

    # Cathédrale Santa Maria del Fiore (Duomo)
    destination = Destination.create!({
      title: "Cathédrale Santa Maria del Fiore",
      latitude: 43.773756,
      longitude: 11.256600,
      address: "Piazza del Duomo, 50122 Firenze FI, Italy",
      description: "La cathédrale de Florence, également connue sous le nom de Duomo, est une merveille architecturale de la Renaissance. Vous pouvez monter au sommet de la coupole pour une vue panoramique de la ville."
    })

    # Ponte Vecchio
    destination = Destination.create!({
      title: "Ponte Vecchio",
      latitude: 43.767704,
      longitude: 11.253191,
      address: "Ponte Vecchio, 50125 Firenze FI, Italy",
      description: "Le Ponte Vecchio est l'un des ponts les plus célèbres de Florence. Il est connu pour ses boutiques de bijoutiers et son charme historique."
    })

    # Palais Pitti (Palazzo Pitti)
    destination = Destination.create!({
      title: "Palais Pitti",
      latitude: 43.764234,
      longitude: 11.248482,
      address: "Piazza de' Pitti, 1, 50125 Firenze FI, Italy",
      description: "Le Palais Pitti est un palais historique de la Renaissance qui abrite plusieurs musées, dont la Galerie Palatine et le Musée de la Mode."
    })

    # Jardins de Boboli (Giardino di Boboli)
    destination = Destination.create!({
      title: "Jardins de Boboli",
      latitude: 43.764680,
      longitude: 11.248484,
      address: "Piazza de' Pitti, 1, 50125 Firenze FI, Italy",
      description: "Les Jardins de Boboli sont des jardins historiques situés derrière le Palais Pitti. Ils offrent une belle promenade parmi les sculptures, les fontaines et les terrasses panoramiques."
    })

    # Basilique Santa Croce
    destination = Destination.create!({
      title: "Basilique Santa Croce",
      latitude: 43.768970,
      longitude: 11.262982,
      address: "Piazza Santa Croce, 16, 50122 Firenze FI, Italy",
      description: "La Basilique Santa Croce est l'une des églises les plus importantes de Florence, abritant les tombeaux de personnalités célèbres telles que Michel-Ange, Galilée et Machiavel."
    })

    # Galerie de l'Académie (Galleria dell'Accademia)
    destination = Destination.create!({
      title: "Galerie de l'Académie",
      latitude: 43.776065,
      longitude: 11.259395,
      address: "Via Ricasoli, 58/60, 50122 Firenze FI, Italy",
      description: "La Galerie de l'Académie est célèbre pour abriter la statue de David de Michel-Ange. Elle présente également d'autres œuvres d'art importantes de la Renaissance florentine."
    })

    # Piazzale Michelangelo
    destination = Destination.create!({
      title: "Piazzale Michelangelo",
      latitude: 43.762175,
      longitude: 11.265396,
      address: "Piazzale Michelangelo, 50125 Firenze FI, Italy",
      description: "Le Piazzale Michelangelo offre l'une des meilleures vues panoramiques de Florence. C'est un endroit populaire pour admirer le coucher de soleil sur la ville."
    })
  else
    found = false
    cptttl = 0
    # DESTINATIONS_CRITERES.keys.each do |style|
    DESTINATIONS_CRITERES[style.to_sym].each do |categories|
      url_overpass = "http://overpass-api.de/api/interpreter?data=[out:json];area[name=\"#{trip.city}\"]->.searchArea;node[#{categories}](area.searchArea);out;"
      cpt_destination = 0
      JSON.parse(URI.open(url_overpass).read)["elements"].each_with_index do |a, n|
        cpt_destination = n
        break if cptttl >= 8 || !a["tags"].key?("name")
        found = true if cptttl >= 2
        cptttl += 1
        lat = a["lat"] if a.key?("lat")
        lon = a["lon"] if a.key?("lon")

        addr = "(#{a["lat"]}, #{a["lon"]})"
        url_mapbox = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{CGI.escape(a["tags"]["name"])}.json?access_token=pk.eyJ1IjoibGFpZ29oIiwiYSI6ImNsbDBudGU1ejBrdDczbnAzYjlybXljMGUifQ.alDjwDZTSREW8A-_G8B9vQ"
        if JSON.parse(URI.open(url_mapbox).read).key?("features")
          if !JSON.parse(URI.open(url_mapbox).read)["features"][0].nil?
            if JSON.parse(URI.open(url_mapbox).read)["features"][0].key?("properties")
              if JSON.parse(URI.open(url_mapbox).read)["features"][0]["properties"].key?("address")
                # puts JSON.parse(URI.open(url_mapbox).read)["features"][0]["properties"]
                addr = JSON.parse(URI.open(url_mapbox).read)["features"][0]["properties"]["address"]
              end
            end
          end
        end

        destination = Destination.create!({
          title: a["tags"]["name"],
          longitude: lon,
          latitude: lat,
          address: addr,
          description: Faker::Lorem.sentence
        })
        TripDestination.create!(
          trip: trip,
          destination: destination,
          position: cptttl
        )
        # puts "- #{cpt_destination} lieu(x) #{categories}" if cpt_destination != 0
      end
    end
  end
  if found
    cpt_trip += 1
    puts ""
    puts "#{trip.city.upcase} => #{cptttl} lieux"
    trip.save!
    n = rand(0..3)
    # puts "#{n} copies"
    n.times do |k|
      copied_trip = trip.dup
      copied_trip.trip_id = trip.id
      trip.destinations.each_with_index do |destination, n|
        TripDestination.create!(
          trip: copied_trip,
          destination: destination,
          position: n
        )
      end

      if k == 0 && cpt_first_user < 10
        cpt_first_user += 1
        copied_trip.tripper = User.first
      else
        copied_trip.tripper = User.where.not(id: planner.id).sample
      end
      copied_trip.save! ? "" : copied_trip.error
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
  first_name: "Janis",
  last_name: "Joplin",
  email: "janis@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/102687903?v=4"
)

user2 = User.create(
  first_name: "Etta",
  last_name: "James",
  email: "etta@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/102727596?v=4"
)

user3 = User.create(
  first_name: "Joan",
  last_name: "Jett",
  email: "joan@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/135238187?v=4"
)

user4 = User.create(
  first_name: "Patti",
  last_name: "Smith",
  email: "patti@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/101594582?v=4"
)

user5 = User.create(
  first_name: "Debbie",
  last_name: "Harry",
  email: "deby@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/101594582?v=4"
)

user6 = User.create(
  first_name: "Astrud",
  last_name: "Gilberto",
  email: "astrud@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/107953331?v=4"
)

user7 = User.create(
  first_name: "Amy",
  last_name: "Whinehouse",
  email: "amy@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139123707?v=4"
)

user8 = User.create(
  first_name: "Nina",
  last_name: "Simone",
  email: "nina@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/130074671?v=4"
)

user9 = User.create(
  first_name: "Billie",
  last_name: "Holiday",
  email: "billie@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124726?v=4"
)

user10 = User.create(
  first_name: "Ella",
  last_name: "Fitzgerald",
  email: "ella@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/130074693?v=4"
)

user11 = User.create(
  first_name: "Robert",
  last_name: "Plant",
  email: "robert@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/60078137?v=4"
)

user12 = User.create(
  first_name: "John",
  last_name: "Lennon",
  email: "john@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/138495721?v=4"
)

user13 = User.create(
  first_name: "Kurt",
  last_name: "Cobain",
  email: "kurt@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688992728/dwty0kmrxptymirqocjk.jpg"
)

user14 = User.create(
  first_name: "Tom",
  last_name: "Jobim",
  email: "tom@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/136320274?v=4"
)

user15 = User.create(
  first_name: "Chet",
  last_name: "Baker",
  email: "chet@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139125894?v=4"
)

user16 = User.create(
  first_name: "Jim",
  last_name: "Morrison",
  email: "jim@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688993845/fvpb8lfyosqeivzds7ez.jpg"
)

user17 = User.create(
  first_name: "Jimi",
  last_name: "Hendrix",
  email: "jimi@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/44208500?v=4"
)

user18 = User.create(
  first_name: "Jim",
  last_name: "Morrison",
  email: "jim@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688993845/fvpb8lfyosqeivzds7ez.jpg"
)

user19 = User.create(
  first_name: "Roger",
  last_name: "Waters",
  email: "roger@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124191?v=4"
)

user20 = User.create(
  first_name: "Miles",
  last_name: "Davis",
  email: "miles@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/118887314?v=4"
)

user21 = User.create(
  first_name: "Mick",
  last_name: "Jagger",
  email: "mick@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/120410801?v=4"
)

user22 = User.create(
  first_name: "Mick",
  last_name: "Jagger",
  email: "mick@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/120410801?v=4"
)

user23 = User.create(
  first_name: "David",
  last_name: "Bowie",
  email: "david@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/136184385?v=4"
)

user24 = User.create(
  first_name: "Iggy",
  last_name: "Pop",
  email: "iggy@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/135331205?v=4"
)

user25 = User.create(
  first_name: "Eddie",
  last_name: "Vedder",
  email: "eddie@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688995034/okfhhgjkc71sqo7mpqpk.jpg"
)

user26 = User.create(
  first_name: "Bruce",
  last_name: "Dickinson",
  email: "bruce@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124434?v=4"
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

# destination_italy1 = Destination.create(
#   address: "Rome, Italy",
#   latitude: 41.9028,
#   longitude: 12.4964,
#   position: 1,
#   description: "Explore the captivating history of Rome as you stand before the ancient Colosseum and wander through the ruins of the Roman Forum. Savor traditional pasta dishes in quaint trattorias and make a wish at the iconic Trevi Fountain, surrounded by the city's timeless beauty."
# )

# destination_italy2 = Destination.create(
#   address: "Florence, Italy",
#   latitude: 43.7696,
#   longitude: 11.2558,
#   position: 2,
#   description: "Indulge in the artistic treasures of Florence, where Michelangelo's David and Botticelli's Birth of Venus reside. Stroll along the Arno River, cross the iconic Ponte Vecchio, and savor gelato in bustling piazzas. Florence's charm and creativity will leave you enchanted."
# )

# destination_italy3 = Destination.create(
#   address: "Venice, Italy",
#   latitude: 45.4408,
#   longitude: 12.3155,
#   position: 3,
#   description: "Embark on a romantic journey through the enchanting canals of Venice, serenaded by the gentle lapping of water against historic palaces. Discover hidden squares, indulge in delectable seafood, and visit the glassmaking island of Murano, where artistry and beauty intertwine."
# )

# trip_destinations = TripDestination.create(
#   trip: trip1,
#   destination: destination_italy1
# )

# trip_destinations = TripDestination.create(
#   trip: trip1,
#   destination: destination_italy2
# )

# trip_destinations = TripDestination.create(
#   trip: trip1,
#   destination: destination_italy3
# )

puts "Done"
