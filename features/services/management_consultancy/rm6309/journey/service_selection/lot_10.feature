@javascript
Feature: Management Consultancy - Lot 10 - Restructuring and insolvency - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 10 - Restructuring and insolvency'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 10 - Restructuring and insolvency'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Accelerated Mergers and Acquisitions                                                                                                                                                                                                                                         |
      | Business review                                                                                                                                                                                                                                                              |
      | Cash-flow review                                                                                                                                                                                                                                                             |
      | Distressed debt restructuring                                                                                                                                                                                                                                                |
      | General restructuring advice                                                                                                                                                                                                                                                 |
      | Insolvency contingency planning                                                                                                                                                                                                                                              |
      | Options analysis                                                                                                                                                                                                                                                             |
      | Capital markets advice                                                                                                                                                                                                                                                       |
      | Economic consulting (Market Economy Operator Principle - “MEOP”)                                                                                                                                                                                                             |
      | International insolvency advice                                                                                                                                                                                                                                              |
      | Pensions advisory                                                                                                                                                                                                                                                            |
      | Restructuring tax advice                                                                                                                                                                                                                                                     |
      | Special administration regimes                                                                                                                                                                                                                                               |
      | Advanced manufacturing, which includes aerospace manufacturing, automotive manufacturing, computers and electrical equipment manufacturing, machinery and equipment manufacturing, shipbuilding, chemicals manufacturing, and space                                          |
      | Aviation                                                                                                                                                                                                                                                                     |
      | Business services, which includes outsourcing, professional services, recruitment services and facilities management                                                                                                                                                         |
      | Construction                                                                                                                                                                                                                                                                 |
      | Consumer, which includes retail, consumer goods, tourism, hospitality and leisure                                                                                                                                                                                            |
      | Defence                                                                                                                                                                                                                                                                      |
      | Education                                                                                                                                                                                                                                                                    |
      | Energy, which includes electricity, gas markets, civil nuclear, oil and gas and refined petroleum products manufacturing                                                                                                                                                     |
      | Financial services                                                                                                                                                                                                                                                           |
      | Health and social care                                                                                                                                                                                                                                                       |
      | Heavy industry, which includes agri-tech, cement manufacturing, construction material, ceramics, plastics manufacturing, rail manufacturing, paper manufacturing, mining, steel manufacturing, fabricated metal products manufacturing and other energy intensive industries |
      | Local authorities                                                                                                                                                                                                                                                            |
      | Sports and leisure                                                                                                                                                                                                                                                           |
      | Technology, media and telecoms                                                                                                                                                                                                                                               |
      | Transport (excluding aviation) which includes maritime and ports, road haulage and logistics, rail, warehousing and storage, and postal and courier services                                                                                                                 |
      | Utilities                                                                                                                                                                                                                                                                    |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Accelerated Mergers and Acquisitions'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Accelerated Mergers and Acquisitions |
    When I check the following items:
      | Business review                |
      | Cash-flow review               |
      | Pensions advisory              |
      | Restructuring tax advice       |
      | Special administration regimes |
      | Local authorities              |
      | Sports and leisure             |
      | Technology, media and telecoms |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Accelerated Mergers and Acquisitions |
      | Business review                      |
      | Cash-flow review                     |
      | Pensions advisory                    |
      | Restructuring tax advice             |
      | Special administration regimes       |
      | Local authorities                    |
      | Sports and leisure                   |
      | Technology, media and telecoms       |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Cash-flow review                |
      | Distressed debt restructuring   |
      | General restructuring advice    |
      | Insolvency contingency planning |
      | Options analysis                |
      | Aviation                        |
      | Construction                    |
      | Sports and leisure              |
      | Technology, media and telecoms  |
      | Utilities                       |
    Then the basket should say '10 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Cash-flow review                |
      | Distressed debt restructuring   |
      | General restructuring advice    |
      | Insolvency contingency planning |
      | Options analysis                |
      | Aviation                        |
      | Construction                    |
      | Sports and leisure              |
      | Technology, media and telecoms  |
      | Utilities                       |
    When I deselect the following items:
      | Aviation                       |
      | Technology, media and telecoms |
    Then the basket should say '8 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Cash-flow review                |
      | Distressed debt restructuring   |
      | General restructuring advice    |
      | Insolvency contingency planning |
      | Options analysis                |
      | Construction                    |
      | Sports and leisure              |
      | Utilities                       |
    When I remove the following items from the basket:
      | Cash-flow review              |
      | Distressed debt restructuring |
      | General restructuring advice  |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Insolvency contingency planning |
      | Options analysis                |
      | Construction                    |
      | Sports and leisure              |
      | Utilities                       |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Distressed debt restructuring   |
      | General restructuring advice    |
      | Insolvency contingency planning |
      | Options analysis                |
      | Special administration regimes  |
      | Aviation                        |
      | Utilities                       |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Distressed debt restructuring   |
      | General restructuring advice    |
      | Insolvency contingency planning |
      | Options analysis                |
      | Special administration regimes  |
      | Aviation                        |
      | Utilities                       |
