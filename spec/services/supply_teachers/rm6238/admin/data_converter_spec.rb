require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Admin::DataConverter do
  describe '.convert_data' do
    # rubocop:disable RSpec/ExampleLength
    it 'converts the data to an importable format' do
      suppliers = JSON.parse(Rails.root.join('spec', 'fixtures', 'supply_teachers', 'rm6238', 'admin', 'current_data_data.json').read)

      expect(described_class.convert_data(suppliers)).to eq(
        [
          {
            id: 'fc597adf-5034-4897-b2fb-2bb5264d8bd4',
            name: 'BARTOLETTI, KOEPP AND NIENOW',
            supplier_frameworks: [
              {
                framework_id: 'RM6238',
                enabled: true,
                supplier_framework_contact_detail: {},
                supplier_framework_lots: [
                  {
                    lot_id: 'RM6238.1',
                    enabled: true,
                    supplier_framework_lot_services: [],
                    supplier_framework_lot_jurisdictions: [
                      {
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_rates: [
                      {
                        position_id: 'RM6238.1.1',
                        rate: 2759,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.2',
                        rate: 2621,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.3',
                        rate: 2483,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.4',
                        rate: 2358,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.5',
                        rate: 3034,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.6',
                        rate: 2882,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.7',
                        rate: 2621,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.8',
                        rate: 2489,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.9',
                        rate: 100,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.10',
                        rate: 2207,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.1.11',
                        rate: 1655,
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_branches: [
                      {
                        lat: 51.538636,
                        lon: -0.0164035,
                        postcode: 'E20 2ST',
                        contact_name: 'Jae Bradtke JD',
                        contact_email: 'jae_bradtke_jd@considine.org',
                        telephone_number: '796.971.2756 x5567',
                        name: 'London',
                        town: 'London',
                        address_line_1: 'London Stadium',
                        address_line_2: 'Queen Elizabeth Olympic Park',
                        county: nil,
                        region: 'Inner London - East'
                      },
                      {
                        lat: 53.64547839999999,
                        lon: -3.0208779,
                        postcode: 'PR8 1RX',
                        contact_name: 'Fr. Theda Ratke',
                        contact_email: 'theda.fr.ratke@ortiz.com',
                        telephone_number: '1-239-638-8229 x18833',
                        name: 'Southport',
                        town: 'Southport',
                        address_line_1: 'Southport Pleasureland',
                        address_line_2: 'Marine Dr',
                        county: 'Merseyside',
                        region: 'Merseyside'
                      }
                    ]
                  }
                ]
              }
            ]
          },
          {
            id: '2a0c8fb0-3e0b-4ca8-b66e-9e9397a26196',
            name: 'BOGAN, REICHERT AND COLLIER',
            supplier_frameworks: [
              {
                framework_id: 'RM6238',
                enabled: true,
                supplier_framework_contact_detail: {
                  additional_details: {
                    master_vendor: {
                      name: 'Ok Kuphal',
                      email: 'bogan.and.collier.reichert@murray.net',
                      telephone_number: '(670) 117-8868 x86891'
                    }
                  }
                },
                supplier_framework_lots: [
                  {
                    lot_id: 'RM6238.2.1',
                    enabled: true,
                    supplier_framework_lot_services: [],
                    supplier_framework_lot_jurisdictions: [
                      {
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_rates: [
                      {
                        position_id: 'RM6238.2.1.1',
                        rate: 3030,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.2',
                        rate: 2878,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.3',
                        rate: 2727,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.4',
                        rate: 2590,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.5',
                        rate: 3333,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.6',
                        rate: 3166,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.7',
                        rate: 2878,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.8',
                        rate: 2734,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.9',
                        rate: 0,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.10',
                        rate: 2424,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.1.11',
                        rate: 1818,
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_branches: []
                  },
                  {
                    lot_id: 'RM6238.2.2',
                    enabled: true,
                    supplier_framework_lot_services: [],
                    supplier_framework_lot_jurisdictions: [
                      {
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_rates: [
                      {
                        position_id: 'RM6238.2.2.1',
                        rate: 5716,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.2',
                        rate: 5430,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.3',
                        rate: 5144,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.4',
                        rate: 4886,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.5',
                        rate: 6287,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.6',
                        rate: 5972,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.7',
                        rate: 5430,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.8',
                        rate: 5158,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.9',
                        rate: 600,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.10',
                        rate: 4572,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.2.2.11',
                        rate: 3429,
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_branches: []
                  }
                ]
              }
            ]
          },
          {
            id: '4b963011-e52c-47a2-982b-a9cb9e40023c',
            name: 'BOYLE, KOEPP AND TURNER',
            supplier_frameworks: [
              {
                framework_id: 'RM6238',
                enabled: true,
                supplier_framework_contact_detail: {
                  additional_details: {
                    education_technology_platform: {
                      name: 'Hildred Padberg',
                      email: 'and.boyle.turner.koepp@lehner-cole.info',
                      telephone_number: '1-564-892-0394 x2677'
                    }
                  }
                },
                supplier_framework_lots: [
                  {
                    lot_id: 'RM6238.4',
                    enabled: true,
                    supplier_framework_lot_services: [],
                    supplier_framework_lot_jurisdictions: [
                      {
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_rates: [
                      {
                        position_id: 'RM6238.4.1',
                        rate: 1951,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.4.2',
                        rate: 1853,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.4.3',
                        rate: 1755,
                        jurisdiction_id: 'GB'
                      },
                      {
                        position_id: 'RM6238.4.4',
                        rate: 1300,
                        jurisdiction_id: 'GB'
                      }
                    ],
                    supplier_framework_lot_branches: []
                  }
                ]
              }
            ]
          }
        ]
      )
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
