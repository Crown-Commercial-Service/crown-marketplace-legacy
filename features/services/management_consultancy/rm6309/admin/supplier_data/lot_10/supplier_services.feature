Feature: Management Consultancy - Admin - Supplier lot data - Lot 10 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUTMANN-PFEFFER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUTMANN-PFEFFER'
    And I click on 'View services' for the lot 'Lot 10 - Restructuring and insolvency'
    Then I am on the 'Lot 10 - Restructuring and insolvency - Services' page
    And the caption is 'GUTMANN-PFEFFER'
    And the supplier should be assigned to the 'services' in 'Primary capabilities' as follows:
      | Service name                         | Has service? |
      | Accelerated Mergers and Acquisitions | Yes          |
      | Business review                      | Yes          |
      | Cash-flow review                     | No           |
      | Distressed debt restructuring        | No           |
      | General restructuring advice         | No           |
      | Insolvency contingency planning      | No           |
      | Options analysis                     | Yes          |
    And the supplier should be assigned to the 'services' in 'Additional capabilities' as follows:
      | Service name                                                     | Has service? |
      | Capital markets advice                                           | Yes          |
      | Economic consulting (Market Economy Operator Principle - “MEOP”) | Yes          |
      | International insolvency advice                                  | No           |
      | Pensions advisory                                                | Yes          |
      | Restructuring tax advice                                         | No           |
      | Special administration regimes                                   | Yes          |
    And the supplier should be assigned to the 'services' in 'Sector specialisms' as follows:
      | Service name                                                                                                                                                                                                                                                                 | Has service? |
      | Advanced manufacturing, which includes aerospace manufacturing, automotive manufacturing, computers and electrical equipment manufacturing, machinery and equipment manufacturing, shipbuilding, chemicals manufacturing, and space                                          | Yes          |
      | Aviation                                                                                                                                                                                                                                                                     | Yes          |
      | Business services, which includes outsourcing, professional services, recruitment services and facilities management                                                                                                                                                         | Yes          |
      | Construction                                                                                                                                                                                                                                                                 | Yes          |
      | Consumer, which includes retail, consumer goods, tourism, hospitality and leisure                                                                                                                                                                                            | No           |
      | Defence                                                                                                                                                                                                                                                                      | No           |
      | Education                                                                                                                                                                                                                                                                    | Yes          |
      | Energy, which includes electricity, gas markets, civil nuclear, oil and gas and refined petroleum products manufacturing                                                                                                                                                     | No           |
      | Financial services                                                                                                                                                                                                                                                           | Yes          |
      | Health and social care                                                                                                                                                                                                                                                       | Yes          |
      | Heavy industry, which includes agri-tech, cement manufacturing, construction material, ceramics, plastics manufacturing, rail manufacturing, paper manufacturing, mining, steel manufacturing, fabricated metal products manufacturing and other energy intensive industries | Yes          |
      | Local authorities                                                                                                                                                                                                                                                            | Yes          |
      | Sports and leisure                                                                                                                                                                                                                                                           | Yes          |
      | Technology, media and telecoms                                                                                                                                                                                                                                               | Yes          |
      | Transport (excluding aviation) which includes maritime and ports, road haulage and logistics, rail, warehousing and storage, and postal and courier services                                                                                                                 | Yes          |
      | Utilities                                                                                                                                                                                                                                                                    | Yes          |
