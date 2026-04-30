# Mobility46 Stockholm parking demo seed data — idempotent, deterministic via srand.

srand(42)

AREAS = [
  # Original six (kept intact — do not change name or spot count to preserve existing rows).
  {
    name: "Norrmalm", prefix: "NOR", spots: 22,
    address: "Sergelgatan 1, 111 57 Stockholm",
    lat: 59.3326, lng: 18.0649,
    description: "Central business district garage steps from Sergels Torg and T-Centralen."
  },
  {
    name: "Östermalm", prefix: "OST", spots: 18,
    address: "Stureplan 4, 114 35 Stockholm",
    lat: 59.3367, lng: 18.0758,
    description: "Premium parking serving Stureplan's restaurants, boutiques, and Saluhall."
  },
  {
    name: "Södermalm", prefix: "SOD", spots: 25,
    address: "Medborgarplatsen 25, 118 72 Stockholm",
    lat: 59.3145, lng: 18.0721,
    description: "Largest area in the network, covering Medborgarplatsen and the Götgatan retail strip."
  },
  {
    name: "Vasastan", prefix: "VAS", spots: 16,
    address: "Odengatan 65, 113 22 Stockholm",
    lat: 59.3429, lng: 18.0498,
    description: "Quiet residential parking around Odenplan and Stockholm Public Library."
  },
  {
    name: "Kungsholmen", prefix: "KUN", spots: 20,
    address: "Fridhemsplan 10, 112 40 Stockholm",
    lat: 59.3322, lng: 18.0307,
    description: "Mixed-use lot serving Kungsholmen residents and the Fridhemsplan transit hub."
  },
  {
    name: "Gamla Stan", prefix: "GAM", spots: 15,
    address: "Stortorget 7, 111 29 Stockholm",
    lat: 59.3253, lng: 18.0712,
    description: "Compact lot serving the Old Town's tourist core and the Royal Palace."
  },

  # New areas covering inner & outer Stockholm.
  {
    name: "Djurgården", prefix: "DJU", spots: 40, jitter: 1.5,
    address: "Djurgårdsvägen 68, 115 21 Stockholm",
    lat: 59.3266, lng: 18.1042,
    description: "Visitor parking serving Skansen, Vasamuseet, and Gröna Lund on the royal park island."
  },
  {
    name: "Skeppsholmen", prefix: "SKE", spots: 25, jitter: 0.7,
    address: "Slupskjulsvägen 28, 111 49 Stockholm",
    lat: 59.3274, lng: 18.0843,
    description: "Compact island lot serving Moderna Museet and the Skeppsholmen guest harbour."
  },
  {
    name: "Ladugårdsgärdet", prefix: "GAR", spots: 35, jitter: 1.3,
    address: "Tegeluddsvägen 80, 115 41 Stockholm",
    lat: 59.3441, lng: 18.0978,
    description: "Wide-format parking spread across Gärdet near the TV tower and Filmhuset."
  },
  {
    name: "Hammarby Sjöstad", prefix: "HAM", spots: 55, jitter: 1.4,
    address: "Sickla Kanalgata 71, 120 67 Stockholm",
    lat: 59.3043, lng: 18.0936,
    description: "Largest waterfront site in the network, covering the Hammarby Sjöstad mixed-use district."
  },
  {
    name: "Liljeholmen", prefix: "LIL", spots: 40, jitter: 1.2,
    address: "Liljeholmsplan 7, 117 61 Stockholm",
    lat: 59.3104, lng: 18.0245,
    description: "Transit-hub parking adjacent to Liljeholmen station and the shopping centre."
  },
  {
    name: "Hornstull", prefix: "HOR", spots: 32,
    address: "Hornstulls Strand 5, 117 39 Stockholm",
    lat: 59.3155, lng: 18.0337,
    description: "Riverside parking on Södermalm's western tip, near Bergsunds Strand."
  },
  {
    name: "Slussen", prefix: "SLU", spots: 40, jitter: 0.8,
    address: "Södermalmstorg 4, 116 45 Stockholm",
    lat: 59.3194, lng: 18.0723,
    description: "Newly rebuilt central interchange between Gamla Stan and Södermalm."
  },
  {
    name: "Lilla Essingen", prefix: "LES", spots: 28,
    address: "Essingestråket 8, 112 66 Stockholm",
    lat: 59.3245, lng: 17.9974,
    description: "Residential island parking serving the Essinge community."
  },
  {
    name: "Stora Essingen", prefix: "SES", spots: 25,
    address: "Stora Essingens Strandväg 3, 112 64 Stockholm",
    lat: 59.3215, lng: 17.9794,
    description: "Quiet outer island parking with views over Mälaren."
  },
  {
    name: "Långholmen", prefix: "LNG", spots: 25, jitter: 0.9,
    address: "Långholmsmuren 26, 117 33 Stockholm",
    lat: 59.3203, lng: 18.0233,
    description: "Park-side parking on the former prison island, now a popular swim spot."
  },
  {
    name: "Marievik", prefix: "MAR", spots: 32,
    address: "Marieviksgatan 25, 117 43 Stockholm",
    lat: 59.3107, lng: 18.0359,
    description: "Office-district parking on the Liljeholmsviken waterfront."
  },
  {
    name: "Aspudden", prefix: "ASP", spots: 30,
    address: "Schlytersvägen 12, 126 49 Hägersten",
    lat: 59.3058, lng: 17.9942,
    description: "Residential parking around Aspudden's commuter station and 1920s cooperative housing."
  },
  {
    name: "Hägersten", prefix: "HAG", spots: 38, jitter: 1.2,
    address: "Personnevägen 26, 126 53 Hägersten",
    lat: 59.3010, lng: 17.9725,
    description: "Suburban hub serving Hägerstensåsen and Västertorp commuters."
  },
  {
    name: "Telefonplan", prefix: "TEL", spots: 30,
    address: "Telefonvägen 30, 126 26 Hägersten",
    lat: 59.3017, lng: 17.9980,
    description: "Mixed parking around the design school (Konstfack) and former LM Ericsson campus."
  },
  {
    name: "Midsommarkransen", prefix: "MID", spots: 28,
    address: "Tellusborgsvägen 92, 126 37 Hägersten",
    lat: 59.3022, lng: 18.0097,
    description: "Tree-lined residential parking near Midsommarkransens torg."
  },
  {
    name: "Stadshagen", prefix: "STA", spots: 30,
    address: "Mariedalsvägen 7, 112 36 Stockholm",
    lat: 59.3358, lng: 18.0153,
    description: "Western Kungsholmen parking serving the sports field and Stadshagsplan."
  },
  {
    name: "Sankt Eriksplan", prefix: "SEP", spots: 35,
    address: "Sankt Eriksplan 3, 113 32 Stockholm",
    lat: 59.3404, lng: 18.0354,
    description: "Busy intersection parking between Vasastan and Kungsholmen."
  },
  {
    name: "Karlaplan", prefix: "KAR", spots: 32,
    address: "Karlaplan 16, 115 20 Stockholm",
    lat: 59.3393, lng: 18.0879,
    description: "Embassy-row parking on the Karlavägen circuit in eastern Östermalm."
  },
  {
    name: "Tessinparken", prefix: "TES", spots: 28,
    address: "Valhallavägen 132, 115 31 Stockholm",
    lat: 59.3497, lng: 18.0937,
    description: "Park-adjacent residential parking in northern Östermalm."
  },
  {
    name: "Ropsten", prefix: "ROP", spots: 32,
    address: "Hjorthagsvägen 6, 115 30 Stockholm",
    lat: 59.3568, lng: 18.1018,
    description: "Northeast terminus parking serving the Lidingö ferry and tram."
  },
  {
    name: "Sundbyberg", prefix: "SUN", spots: 45, jitter: 1.3,
    address: "Sturegatan 14, 172 31 Sundbyberg",
    lat: 59.3614, lng: 17.9707,
    description: "Border municipality parking around Sundbybergs centrum and station."
  },
  {
    name: "Solna Centrum", prefix: "SOL", spots: 50, jitter: 1.4,
    address: "Solna Centrum, 171 45 Solna",
    lat: 59.3596, lng: 18.0001,
    description: "Mall-adjacent parking serving Solna Centrum, Karolinska, and the Friends Arena commuters."
  }
].freeze

SPOT_TYPE_WEIGHTS    = { standard: 70, ev_charging: 18, accessible: 8, motorcycle: 4 }.freeze
SPOT_STATUS_WEIGHTS  = { available: 55, occupied: 38, reserved: 5, out_of_service: 2 }.freeze
POWER_KW_WEIGHTS     = { 22 => 50, 11 => 25, 50 => 18, 150 => 7 }.freeze
CONNECTOR_WEIGHTS    = { type2: 75, ccs: 22, chademo: 3 }.freeze
CHARGER_STAT_WEIGHTS = { idle: 80, in_use: 18, faulted: 2 }.freeze

ZONE_LETTERS = %w[A B C D E F].freeze

def weighted_pick(weights)
  total = weights.values.sum
  r = rand * total
  acc = 0.0
  weights.each do |key, weight|
    acc += weight
    return key if r < acc
  end
  weights.keys.last
end

def jitter_lat(scale = 1.0)
  ((rand * 0.0030) - 0.0015) * scale
end

def jitter_lng(scale = 1.0)
  ((rand * 0.0056) - 0.0028) * scale
end

spot_count = 0
charger_count = 0

AREAS.each do |area_def|
  area = ParkingArea.find_or_create_by!(name: area_def[:name]) do |a|
    a.description = area_def[:description]
    a.address     = area_def[:address]
    a.city        = area_def[:address].include?("Sundbyberg") ? "Sundbyberg" :
                    area_def[:address].include?("Solna") ? "Solna" :
                    area_def[:address].include?("Hägersten") ? "Hägersten" :
                    "Stockholm"
    a.lat         = area_def[:lat]
    a.lng         = area_def[:lng]
  end

  scale = area_def[:jitter] || 1.0

  area_def[:spots].times do |i|
    zone = ZONE_LETTERS[(i / 8).clamp(0, ZONE_LETTERS.length - 1)]
    identifier = "#{area_def[:prefix]}-#{zone}-#{format('%02d', i + 1)}"

    spot = ParkingSpot.find_or_create_by!(identifier: identifier) do |s|
      s.parking_area = area
      s.lat          = (area_def[:lat] + jitter_lat(scale)).round(7)
      s.lng          = (area_def[:lng] + jitter_lng(scale)).round(7)
      s.spot_type    = weighted_pick(SPOT_TYPE_WEIGHTS)
      s.status       = weighted_pick(SPOT_STATUS_WEIGHTS)
    end

    spot_count += 1

    next unless spot.spot_type == "ev_charging"

    Charger.find_or_create_by!(parking_spot: spot) do |c|
      c.power_kw       = weighted_pick(POWER_KW_WEIGHTS)
      c.connector_type = weighted_pick(CONNECTOR_WEIGHTS)
      c.price_per_kwh  = (rand * 3.5 + 3.5).round(2)
      c.status         = weighted_pick(CHARGER_STAT_WEIGHTS)
    end

    charger_count += 1
  end
end

puts "Seeded #{ParkingArea.count} areas, #{ParkingSpot.count} spots, #{Charger.count} chargers."
