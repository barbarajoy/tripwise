require 'pexels'
require "json"
require "open-uri"
require 'cgi'

pex = Pexels::Client.new(ENV["PEXELS_API_KEY"])

CITYS = ["Rome", "Venise", "Florence", "Milan", "Paris", "London", "Dubai", "Singapore", "Kuala Lumpur",
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

  COMMENTS = [
"Bienvenue dans ce lieu magique où l'histoire s'entrelace avec le modernisme. Vous serez captivé par ses ruelles pittoresques, son mélange architectural surprenant, son vivier culturel foisonnant et sa cuisine locale qui ravira vos papilles. Partez à la découverte de ses jardins luxuriants, faites la connaissance de ses habitants accueillants et plongez-vous dans l'ambiance envoûtante de cette métropole cosmopolite. Quelle que soit votre provenance, cette ville réserve une expérience unique à chaque voyageur.",
"Dans cette cité envoûtante, l'histoire et la modernité se côtoient harmonieusement. Vous serez émerveillé par ses rues vivantes, sa diversité architecturale, sa scène culturelle florissante et ses mets locaux exquis. Explorez ses espaces verts paisibles, rencontrez des gens chaleureux et plongez dans l'atmosphère incomparable de cette destination cosmopolite. Peu importe d'où vous venez, cette ville a un charme unique pour chaque voyageur.",
"Explorez cette culture fascinante où le passé et le présent se fondent parfaitement. Vous serez enchanté par les rues animées, l'architecture diversifiée, la scène culturelle vibrante et la délicieuse cuisine locale. Imprégnez-vous de la quiétude de ses parcs verdoyants, faites la rencontre de ses habitants accueillants et plongez dans l'atmosphère exceptionnelle de cette métropole cosmopolite. Peu importe votre origine, cette ville réserve des trésors à chaque voyageur.",
"Bienvenue dans cette destination unique où l'histoire rencontre le contemporain de façon magistrale. Vous découvrirez des rues pleines de vie, une architecture éclectique, une scène culturelle riche et une gastronomie locale exquise. Explorez ses parcs verdoyants, rencontrez des habitants chaleureux et plongez dans l'atmosphère incomparable de cette métropole cosmopolite. Quelle que soit votre provenance, cette ville a quelque chose d'extraordinaire à offrir à chaque voyageur.",
"Découvrez cette culture étonnante, où le passé et le présent s'entremêlent harmonieusement. Vous serez charmé par les rues animées, la diversité architecturale, la scène culturelle dynamique et la délicieuse cuisine locale. Explorez ses parcs verdoyants, rencontrez des habitants accueillants et plongez dans l'atmosphère unique de cette destination cosmopolite. Peu importe d'où vous venez, cette ville réserve une expérience spéciale à chaque voyageur.",
"Bienvenue dans cette ville où le patrimoine historique se fond parfaitement avec la modernité. Vous découvrirez des rues animées, une architecture variée, une scène culturelle florissante et une cuisine locale délicieuse. Explorez ses espaces verts paisibles, rencontrez des habitants accueillants et plongez dans l'ambiance cosmopolite de cette destination. Quelle que soit votre provenance, cette ville saura vous surprendre.",
"Explorez cette culture fascinante où l'histoire et le présent coexistent en parfaite harmonie. Vous serez émerveillé par les rues animées, la diversité architecturale, la scène culturelle effervescente et la cuisine locale exquise. Partez à la découverte de ses parcs verdoyants, faites la connaissance de ses habitants chaleureux et plongez dans l'atmosphère unique de cette destination cosmopolite. Quel que soit votre point de départ, cette ville a quelque chose de spécial à offrir à chaque voyageur.",
"Bienvenue dans cette destination où l'héritage du passé se marie avec le dynamisme du présent. Vous découvrirez des rues pleines de vie, une architecture diversifiée, une scène culturelle riche et une cuisine locale savoureuse. Explorez ses parcs verdoyants, faites la rencontre de ses habitants accueillants et plongez dans l'atmosphère incomparable de cette métropole cosmopolite. Peu importe votre origine, cette ville réserve des merveilles à chaque voyageur.",
"Découvrez cette culture incroyable où le passé et le présent s'entrelacent harmonieusement. Vous serez séduit par les rues animées, l'architecture variée, la scène culturelle foisonnante et la cuisine locale délicieuse. Explorez ses espaces verts paisibles, faites la connaissance de ses habitants chaleureux et plongez dans l'atmosphère unique de cette destination cosmopolite. Quelle que soit votre provenance, cette ville a quelque chose d'extraordinaire à offrir à chaque voyageur."
  ]


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


user_laura = User.create(
  first_name: "Laura",
  last_name: "Beauvais",
  email: "laura@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/101594582?v=4"
)

user_barbara = User.create(
  first_name: "Barbara",
  last_name: "Joy",
  email: "barbara@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/107953331?v=4"
)

user_audran = User.create(
  first_name: "Joan",
  last_name: "Jett",
  email: "test@test.test",
  password: "testtest",
  image_url: "https://avatars.githubusercontent.com/u/135238187?v=4"
)

User.create(
  first_name: "Patti",
  last_name: "Smith",
  email: "patti@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/101594582?v=4"
)

User.create(
  first_name: "Debbie",
  last_name: "Harry",
  email: "deby@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/101594582?v=4"
)

User.create(
  first_name: "Astrud",
  last_name: "Gilberto",
  email: "astrud@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/107953331?v=4"
)

User.create(
  first_name: "Amy",
  last_name: "Whinehouse",
  email: "amy@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139123707?v=4"
)

User.create(
  first_name: "Nina",
  last_name: "Simone",
  email: "nina@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/130074671?v=4"
)

User.create(
  first_name: "Billie",
  last_name: "Holiday",
  email: "billie@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124726?v=4"
)

User.create(
  first_name: "Ella",
  last_name: "Fitzgerald",
  email: "ella@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/130074693?v=4"
)

User.create(
  first_name: "Robert",
  last_name: "Plant",
  email: "robert@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/60078137?v=4"
)

User.create(
  first_name: "John",
  last_name: "Lennon",
  email: "john@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/138495721?v=4"
)

User.create(
  first_name: "Kurt",
  last_name: "Cobain",
  email: "kurt@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688992728/dwty0kmrxptymirqocjk.jpg"
)

User.create(
  first_name: "Tom",
  last_name: "Jobim",
  email: "tom@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/136320274?v=4"
)

User.create(
  first_name: "Chet",
  last_name: "Baker",
  email: "chet@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139125894?v=4"
)

User.create(
  first_name: "Jim",
  last_name: "Morrison",
  email: "jim@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688993845/fvpb8lfyosqeivzds7ez.jpg"
)

User.create(
  first_name: "Jimi",
  last_name: "Hendrix",
  email: "jimi@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/44208500?v=4"
)

User.create(
  first_name: "Jim",
  last_name: "Morrison",
  email: "jim@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688993845/fvpb8lfyosqeivzds7ez.jpg"
)

User.create(
  first_name: "Roger",
  last_name: "Waters",
  email: "roger@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124191?v=4"
)

User.create(
  first_name: "Miles",
  last_name: "Davis",
  email: "miles@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/118887314?v=4"
)

User.create(
  first_name: "Mick",
  last_name: "Jagger",
  email: "mick@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/120410801?v=4"
)

User.create(
  first_name: "Mick",
  last_name: "Jagger",
  email: "mick@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/120410801?v=4"
)

User.create(
  first_name: "David",
  last_name: "Bowie",
  email: "david@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/136184385?v=4"
)

User.create(
  first_name: "Iggy",
  last_name: "Pop",
  email: "iggy@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/135331205?v=4"
)

User.create(
  first_name: "Eddie",
  last_name: "Vedder",
  email: "eddie@example.com",
  password: "password",
  image_url: "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1688995034/okfhhgjkc71sqo7mpqpk.jpg"
)

User.create(
  first_name: "Bruce",
  last_name: "Dickinson",
  email: "bruce@example.com",
  password: "password",
  image_url: "https://avatars.githubusercontent.com/u/139124434?v=4"
)


# User.create({ email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, image_url: IMAGE_URL.sample })


cpt_trip = 0
cpt_trip_tentative = 0
while cpt_trip < 5
  # rand(20..30).times do |j|
  # CITYS.each_with_index do |city, j|
  city = CITYS[cpt_trip_tentative]
  cpt_trip_tentative += 1

  if cpt_trip < 3
    style = "romantic"
  elsif cpt_trip == 3
    style = "luxury"
  else
    style = DESTINATIONS_CRITERES.keys.sample.to_s
  end
  picture = []
  picture = pex.photos.search(city, per_page: 2).photos
  if picture.length > 0
    maphoto = picture.sample.src["large"]
  else
    maphoto = "https://www.deutschland.de/sites/default/files/styles/image_container/public/media/image/living-in-germany-city-frankfurt-skyline.jpg?itok=ZSTPGApy"
  end
  if cpt_trip < 3
    planner = User.first
  else
    planner = User.all.sample
  end
  if cpt_trip == 0
    comment = "Rome, the Eternal City, is a treasure trove of history and culture that transports you through the centuries. Explore its picturesque alleyways, admire the majestic remnants of the Roman Empire like the Colosseum and the Roman Forum, and marvel at the grand architecture of St. Peter's Basilica. Enjoy delicious Italian cuisine in local trattorias and end the day by tossing a coin into the Trevi Fountain for a guaranteed return to Rome. An unforgettable experience awaits you in this enchanting city."
  elsif cpt_trip == 1
    comment = "Venice, known as the 'City of Canals,' is a one-of-a-kind city located in Italy, built on an archipelago of 118 small interconnected islands connected by a network of canals and bridges. Explore its narrow streets, admire its medieval architecture, and discover priceless artistic treasures in its churches and museums. Don't miss a gondola ride on the picturesque canals and savor delicious Italian cuisine in its charming restaurants. Come and experience something extraordinary in this magical city where water is the main road, and history flows at every street corner."
  elsif cpt_trip == 2
    comment = "Florence, known as the 'Pearl of the Renaissance,' is a beautiful and historically rich Italian city located in Tuscany. It is famous for its stunning architecture, renowned museums housing artistic treasures like Michelangelo's 'David,' picturesque cobblestone streets, and its romantic ambiance along the Arno River. Immerse yourself in Italian culture, savor delicious cuisine, and explore the city's exceptional artistic heritage by visiting landmarks such as the Florence Cathedral and the Ponte Vecchio. Florence is a true treasure of art, history, and beauty, not to be missed on your trip to Italy."
  elsif cpt_trip == 3
    comment = "Milan, the capital of fashion and design in Italy, is a cosmopolitan metropolis located in Lombardy. It is known for its avant-garde style, dynamic art scene, and fascinating historical heritage. You will be dazzled by its contemporary architecture, world-renowned museums like the Brera Art Gallery, and its vibrant atmosphere along the Naviglio Grande canal. Explore the richness of Italian cuisine in local trattorias, discover artistic treasures like Leonardo da Vinci's 'The Last Supper' fresco and the majestic Milan Cathedral. Milan embodies the perfect fusion of modernity and history, making it a must-visit destination on your trip to Italy."
  else
    comment = COMMENTS.sample
  end

  if cpt_trip == 0
    titre = "Super cute romantic trip in Rome, Italy"
  elsif cpt_trip == 1
    titre = "Discover Venise, in Italy, with your other half"
  elsif cpt_trip == 2
    titre = "Enchanting Florence: A Romantic Escape in the Heart of Italy"
  elsif cpt_trip == 3
    titre = "Milan: Epitome of Luxury in Italy!"
  else
    titre = "#{Faker::Adjective.positive.capitalize} trip at #{city}"
  end

  if cpt_trip == 0
    budget = 10000
  elsif cpt_trip == 1
    budget = 2400
  elsif cpt_trip == 2
    budget = 1000
  elsif cpt_trip == 3
    budget = 1700
  else
    budget = rand(10..1000)*10
  end

  trip = Trip.new({
    title: titre,
    image_url: maphoto,
    comment: comment,
    budget: budget,
    city: city,
    planner: planner,
    tripper: planner,
    style: style
  })


  found = true
  cptttl = 8
  if cpt_trip == 0
    # Colosseum in Rome
    destination = Destination.create!({
      title: "Colosseum in Rome",
      latitude: 41.890210,
      longitude: 12.492231,
      address: "Piazza del Colosseo, 1, 00184 Roma RM, Italy",
      description: "The Colosseum is an ancient Roman amphitheater located in the center of Rome. It's one of the most iconic monuments of ancient Rome and a must-visit tourist site."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # St. Peter's Basilica
    destination = Destination.create!({
      title: "St. Peter's Basilica",
      latitude: 41.902240,
      longitude: 12.453650,
      address: "Piazza San Pietro, 00120 Vatican City",
      description: "St. Peter's Basilica is one of the largest churches in the world and an important religious site located in Vatican City. It's renowned for its majestic architecture and houses numerous famous works of art."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 2
    )

    # Trevi Fountain
    destination = Destination.create!({
      title: "Trevi Fountain",
      latitude: 41.900933,
      longitude: 12.483265,
      address: "Piazza di Trevi, 00187 Roma RM, Italy",
      description: "The Trevi Fountain is one of the most famous fountains in the world. Visitors traditionally throw a coin into the fountain to ensure a return to Rome."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 3
    )

    # The Pantheon
    destination = Destination.create!({
      title: "The Pantheon",
      latitude: 41.898615,
      longitude: 12.476833,
      address: "Piazza della Rotonda, 00186 Roma RM, Italy",
      description: "The Pantheon is a well-preserved ancient Roman temple that is now a church. It is famous for its impressive dome and remarkable architecture."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 4
    )

    # Borghese Gallery
    destination = Destination.create!({
      title: "Borghese Gallery",
      latitude: 41.914250,
      longitude: 12.492389,
      address: "Piazzale Scipione Borghese, 5, 00197 Roma RM, Italy",
      description: "The Borghese Gallery is a museum housing an impressive collection of artworks, including sculptures by Bernini, paintings by Caravaggio and Raphael, as well as Roman antiquities."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 5
    )

    # Spanish Steps
    destination = Destination.create!({
      title: "Spanish Steps",
      latitude: 41.905694,
      longitude: 12.483732,
      address: "Piazza di Spagna, 00187 Roma RM, Italy",
      description: "The Spanish Steps is a famous square in Rome, known for its monumental staircase, the Trinità dei Monti staircase, and Bernini's Barcaccia Fountain."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 6
    )

    # Roman Forum
    destination = Destination.create!({
      title: "Roman Forum",
      latitude: 41.892480,
      longitude: 12.485396,
      address: "Via della Salara Vecchia, 5/6, 00186 Roma RM, Italy",
      description: "The Roman Forum was the political, religious, and commercial center of ancient Rome. Today in ruins, it provides a fascinating glimpse into Roman history."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 7
    )

    # Vatican Museums
    destination = Destination.create!({
      title: "Vatican Museums",
      latitude: 41.906188,
      longitude: 12.453639,
      address: "Viale Vaticano, 00165 Vatican City",
      description: "The Vatican Museums house an extensive collection of art and antiquities, including the Sistine Chapel, famous for its frescoes by Michelangelo."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 8
    )
  elsif cpt_trip == 1
    # Place Saint-Marc
    destination = Destination.create!({
      title: "Place Saint-Marc",
      latitude: 45.434190,
      longitude: 12.338780,
      address: "Piazza San Marco, 30100 Venezia VE, Italy",
      description: "Place Saint-Marc is the main square of Venice and one of the city's most important historical and cultural centers. It is famous for St. Mark's Basilica, the Clock Tower, and the Doge's Palace."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Rialto Bridge
    destination = Destination.create!({
      title: "Rialto Bridge",
      latitude: 45.438682,
      longitude: 12.335020,
      address: "Ponte di Rialto, 30100 Venezia VE, Italy",
      description: "The Rialto Bridge is one of the most iconic bridges in Venice. It spans the Grand Canal and is surrounded by shops and markets."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 2
    )

    # Doge's Palace
    destination = Destination.create!({
      title: "Doge's Palace",
      latitude: 45.434334,
      longitude: 12.339266,
      address: "Piazza San Marco, 1, 30124 Venezia VE, Italy",
      description: "The Doge's Palace is a magnificent Venetian palace that served as the official residence of the doges of Venice. Today, it houses a museum and is famous for its architecture and artwork."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 3
    )

    # Burano Island
    destination = Destination.create!({
      title: "Burano Island",
      latitude: 45.485878,
      longitude: 12.416548,
      address: "Burano, 30142 Venezia VE, Italy",
      description: "Burano Island is famous for its colorful houses and artisanal lace. It's a picturesque place to stroll and discover the local culture."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 4
    )

    # Murano Island
    destination = Destination.create!({
      title: "Murano Island",
      latitude: 45.457806,
      longitude: 12.355586,
      address: "Murano, 30141 Venezia VE, Italy",
      description: "Murano Island is renowned for its glass craftsmanship, especially its talented glassblowers. You can visit glass workshops and explore the art of glassblowing."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 5
    )

    # Bridge of Sighs
    destination = Destination.create!({
      title: "Bridge of Sighs",
      latitude: 45.434825,
      longitude: 12.340479,
      address: "Rio di Palazzo, 30100 Venezia VE, Italy",
      description: "The Bridge of Sighs is a covered bridge that connects the Doge's Palace to the prisons of Venice. Its name comes from the legend that prisoners sighed as they passed through the bridge, seeing Venice for the last time."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 6
    )

    # Giudecca Island
    destination = Destination.create!({
      title: "Giudecca Island",
      latitude: 45.4260821,
      longitude: 12.3182622,
      address: "Giudecca, 30100 Venezia VE, Italy",
      description: "Giudecca Island offers a panoramic view of Venice and is a peaceful place to escape the city's hustle and bustle. You'll find historical churches and an authentic atmosphere here."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 7
    )

    # Guggenheim Museum in Venice
    destination = Destination.create!({
      title: "Guggenheim Museum in Venice",
      latitude: 45.430876,
      longitude: 12.332588,
      address: "Dorsoduro, 701-704, 30123 Venezia VE, Italy",
      description: "The Guggenheim Museum in Venice houses a collection of modern and contemporary art in a historic Venetian palace. It features works by renowned 20th-century artists."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 8
    )
  elsif cpt_trip == 2
    # Uffizi Gallery (Galleria degli Uffizi)
    destination = Destination.create!({
      title: "Uffizi Gallery",
      latitude: 43.769562,
      longitude: 11.255814,
      address: "Piazzale degli Uffizi, 6, 50122 Firenze FI, Italy",
      description: "The Uffizi Gallery is one of the most famous art museums in the world, housing an extensive collection of Italian Renaissance masterpieces, including works by Botticelli, Michelangelo, and Leonardo da Vinci."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Cathedral of Santa Maria del Fiore (Duomo)
    destination = Destination.create!({
      title: "Cathedral of Santa Maria del Fiore",
      latitude: 43.773756,
      longitude: 11.256600,
      address: "Piazza del Duomo, 50122 Firenze FI, Italy",
      description: "The Florence Cathedral, also known as the Duomo, is an architectural marvel of the Renaissance. You can climb to the top of the dome for a panoramic view of the city."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 2
    )

    # Ponte Vecchio
    destination = Destination.create!({
      title: "Ponte Vecchio",
      latitude: 43.767704,
      longitude: 11.253191,
      address: "Ponte Vecchio, 50125 Firenze FI, Italy",
      description: "The Ponte Vecchio is one of Florence's most famous bridges. It is known for its jewelry shops and historic charm."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 3
    )

    # Pitti Palace (Palazzo Pitti)
    destination = Destination.create!({
      title: "Pitti Palace",
      latitude: 43.764234,
      longitude: 11.248482,
      address: "Piazza de' Pitti, 1, 50125 Firenze FI, Italy",
      description: "Pitti Palace is a historic Renaissance palace that houses several museums, including the Palatine Gallery and the Fashion Museum."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 4
    )

    # Boboli Gardens (Giardino di Boboli)
    destination = Destination.create!({
      title: "Boboli Gardens",
      latitude: 43.764680,
      longitude: 11.248484,
      address: "Piazza de' Pitti, 1, 50125 Firenze FI, Italy",
      description: "The Boboli Gardens are historic gardens located behind Pitti Palace. They offer a beautiful stroll among sculptures, fountains, and panoramic terraces."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 5
    )

    # Basilica of Santa Croce
    destination = Destination.create!({
      title: "Basilica of Santa Croce",
      latitude: 43.768970,
      longitude: 11.262982,
      address: "Piazza Santa Croce, 16, 50122 Firenze FI, Italy",
      description: "The Basilica of Santa Croce is one of the most important churches in Florence, housing the tombs of famous figures such as Michelangelo, Galileo, and Machiavelli."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 6
    )

    # Academy Gallery (Galleria dell'Accademia)
    destination = Destination.create!({
      title: "Academy Gallery",
      latitude: 43.776065,
      longitude: 11.259395,
      address: "Via Ricasoli, 58/60, 50122 Firenze FI, Italy",
      description: "The Academy Gallery is famous for housing Michelangelo's statue of David. It also features other important artworks from the Florentine Renaissance."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 7
    )

    # Piazzale Michelangelo
    destination = Destination.create!({
      title: "Piazzale Michelangelo",
      latitude: 43.762175,
      longitude: 11.265396,
      address: "Piazzale Michelangelo, 50125 Firenze FI, Italy",
      description: "Piazzale Michelangelo offers one of the best panoramic views of Florence. It's a popular spot to admire the sunset over the city."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 8
    )
  elsif cpt_trip == 3
    # Uffizi Gallery (Galleria degli Uffizi)
    destination = Destination.create!({
      title: "Uffizi Gallery",
      latitude: 43.769562,
      longitude: 11.255814,
      address: "Piazzale degli Uffizi, 6, 50122 Florence, Italy",
      description: "The Uffizi Gallery is one of the most famous art museums in the world, housing an extensive collection of Italian Renaissance masterpieces, including works by Botticelli, Michelangelo, and Leonardo da Vinci."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 1
    )

    # Cathedral of Santa Maria del Fiore (Duomo)
    destination = Destination.create!({
      title: "Cathedral of Santa Maria del Fiore",
      latitude: 43.773756,
      longitude: 11.256600,
      address: "Piazza del Duomo, 50122 Florence, Italy",
      description: "The Florence Cathedral, also known as the Duomo, is an architectural marvel of the Renaissance. You can climb to the top of the dome for a panoramic view of the city."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 2
    )

    # Ponte Vecchio
    destination = Destination.create!({
      title: "Ponte Vecchio",
      latitude: 43.767704,
      longitude: 11.253191,
      address: "Ponte Vecchio, 50125 Florence, Italy",
      description: "The Ponte Vecchio is one of Florence's most famous bridges. It is known for its jewelry shops and historical charm."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 3
    )

    # Pitti Palace (Palazzo Pitti)
    destination = Destination.create!({
      title: "Pitti Palace",
      latitude: 43.764234,
      longitude: 11.248482,
      address: "Piazza de' Pitti, 1, 50125 Florence, Italy",
      description: "The Pitti Palace is a historic Renaissance palace housing several museums, including the Palatine Gallery and the Museum of Fashion."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 4
    )

    # Boboli Gardens (Giardino di Boboli)
    destination = Destination.create!({
      title: "Boboli Gardens",
      latitude: 43.764680,
      longitude: 11.248484,
      address: "Piazza de' Pitti, 1, 50125 Florence, Italy",
      description: "The Boboli Gardens are historic gardens located behind the Pitti Palace. They offer a beautiful stroll among sculptures, fountains, and panoramic terraces."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 5
    )

    # Basilica of Santa Croce
    destination = Destination.create!({
      title: "Basilica of Santa Croce",
      latitude: 43.768970,
      longitude: 11.262982,
      address: "Piazza Santa Croce, 16, 50122 Florence, Italy",
      description: "The Basilica of Santa Croce is one of the most important churches in Florence, housing the tombs of famous personalities such as Michelangelo, Galileo, and Machiavelli."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 6
    )

    # Academy Gallery (Galleria dell'Accademia)
    destination = Destination.create!({
      title: "Academy Gallery",
      latitude: 43.776065,
      longitude: 11.259395,
      address: "Via Ricasoli, 58/60, 50122 Florence, Italy",
      description: "The Academy Gallery is famous for housing Michelangelo's statue of David. It also features other important artworks from the Florentine Renaissance."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 7
    )

    # Piazzale Michelangelo
    destination = Destination.create!({
      title: "Piazzale Michelangelo",
      latitude: 43.762175,
      longitude: 11.265396,
      address: "Piazzale Michelangelo, 50125 Florence, Italy",
      description: "Piazzale Michelangelo offers one of the best panoramic views of Florence. It is a popular spot to admire the sunset over the city."
    })
    TripDestination.create!(
      trip: trip,
      destination: destination,
      position: 8
    )
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
          position: n + 1
        )
      end

      copied_trip.tripper = User.where.not(id: [planner.id, user_barbara.id]).sample
      copied_trip.save!
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

puts "Done"
