def stub_geocoder(location)
  location_data = LOCATION_CORDINATES[location]

  Geocoder::Lookup::Test.add_stub(
    location_data[:postcode], location_data[:location]
  )
end

def reset_geocoder
  Geocoder::Lookup::Test.reset
end

LOCATION_CORDINATES = {
  'London' => {
    postcode: 'SW1A 1AA',
    location: [{ 'coordinates' => [51.5010102, -0.1415626] }]
  },
  'Liverpool' => {
    postcode: 'L3 9PP',
    location: [{ 'coordinates' => [53.4000175, -2.993847] }]
  },
  'Birmingham' => {
    postcode: 'B6 6HE',
    location: [{ 'coordinates' => [52.5092161, -1.8847721] }]
  }
}.freeze
