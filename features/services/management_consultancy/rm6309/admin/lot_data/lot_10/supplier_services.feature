Feature: Management Consultancy - Admin - Supplier lot data - Lot 10 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUTMANN-PFEFFER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I click on 'View services' for the lot 'Lot 10 - Restructuring and insolvency'
    Then I am on the 'Lot 10 - Restructuring and insolvency View services' page
    And the caption is 'GUTMANN-PFEFFER'
    And the supplier should be assigned to the 'services' in 'Primary capabilities' as follows:
      | Accelerated Mergers and Acquisitions |
      | Business review                      |
      | Options analysis                     |
    And the supplier should be assigned to the 'services' in 'Additional capabilities' as follows:
      | Capital markets advice                                           |
      | Economic consulting (Market Economy Operator Principle - “MEOP”) |
      | Pensions advisory                                                |
      | Special administration regimes                                   |
    And the supplier should be assigned to the 'services' in 'Sector specialisms' as follows:
      | Advanced manufacturing, which includes aerospace manufacturing, automotive manufacturing, computers and electrical equipment manufacturing, machinery and equipment manufacturing, shipbuilding, chemicals manufacturing, and space                                          |
      | Aviation                                                                                                                                                                                                                                                                     |
      | Business services, which includes outsourcing, professional services, recruitment services and facilities management                                                                                                                                                         |
      | Construction                                                                                                                                                                                                                                                                 |
      | Education                                                                                                                                                                                                                                                                    |
      | Financial services                                                                                                                                                                                                                                                           |
      | Health and social care                                                                                                                                                                                                                                                       |
      | Heavy industry, which includes agri-tech, cement manufacturing, construction material, ceramics, plastics manufacturing, rail manufacturing, paper manufacturing, mining, steel manufacturing, fabricated metal products manufacturing and other energy intensive industries |
      | Local authorities                                                                                                                                                                                                                                                            |
      | Sports and leisure                                                                                                                                                                                                                                                           |
      | Technology, media and telecoms                                                                                                                                                                                                                                               |
      | Transport (excluding aviation) which includes maritime and ports, road haulage and logistics, rail, warehousing and storage, and postal and courier services                                                                                                                 |
      | Utilities                                                                                                                                                                                                                                                                    |
