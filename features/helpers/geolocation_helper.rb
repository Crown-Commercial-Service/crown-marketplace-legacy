def stub_geocoder(location)
  location_data_item = LOCATION_CORDINATES[location]

  location_data_item.each do |location_data|
    Geocoder::Lookup::Test.add_stub(
      location_data[:postcode], location_data[:location]
    )
  end

  Geocoder::Lookup::Test.add_stub('SW1 1AA', [{ 'coordinates' => [] }])
end

def reset_geocoder
  Geocoder::Lookup::Test.reset
end

LOCATION_CORDINATES = {
  'London' => [
    {
      postcode: 'SW1A 1AA',
      location: [{ 'coordinates' => [51.5010102, -0.1415626] }]
    },
    {
      postcode: 'E14 4PU',
      location: [{ 'coordinates' => [51.50458599115668, -0.02208052729799974] }]
    },
    {
      postcode: 'E20 2ST',
      location: [{ 'coordinates' => [51.53856612802023, -0.016517049198377255] }]
    },
    {
      postcode: 'TW2 7BA',
      location: [{ 'coordinates' => [51.46190833253159, -0.340934872716188] }]
    },
    {
      postcode: 'SS2 6NQ',
      location: [{ 'coordinates' => [51.549072447921404, 0.7016791349027106] }]
    }
  ],
  'Liverpool' => [
    {
      postcode: 'L3 9PP',
      location: [{ 'coordinates' => [53.4000175, -2.993847] }]
    },
    {
      postcode: 'L4 0TH',
      location: [{ 'coordinates' => [53.43134641218853, -2.960931536892127] }]
    },
    {
      postcode: 'L24 1YD',
      location: [{ 'coordinates' => [53.33543706989522, -2.8525950536169677] }]
    },
    {
      postcode: 'PR8 1RX',
      location: [{ 'coordinates' => [53.64815863047592, -3.0172629561364004] }]
    },
    {
      postcode: 'M16 0RA',
      location: [{ 'coordinates' => [53.46367330827036, -2.2929726032049316] }]
    },

  ],
  'Birmingham' => [
    {
      postcode: 'B6 6HE',
      location: [{ 'coordinates' => [52.5092161, -1.8847721] }]
    },
    {
      postcode: 'B2 4BJ',
      location: [{ 'coordinates' => [52.4789997328729, -1.9007014905137978] }]
    },
    {
      postcode: 'DY1 4AL',
      location: [{ 'coordinates' => [52.524659858134505, -2.047541022496625] }]
    },
    {
      postcode: 'WV1 4QR',
      location: [{ 'coordinates' => [52.59117109252977, -2.1304508109396623] }]
    },
    {
      postcode: 'NG2 6AG',
      location: [{ 'coordinates' => [52.93691728961155, -1.1322526160932878] }]
    },
  ]
}.freeze
