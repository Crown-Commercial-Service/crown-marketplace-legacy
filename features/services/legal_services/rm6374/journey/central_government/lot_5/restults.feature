Feature: Legal services -  Central governemnt - Lot 5 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6374' framework in 'legal services'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes' for 'requirement replace an existing contract'
    And I select 'Likely' for 'requirement being awarded'
    And I select 'Yes' for 'CCS contact you'
    And I click on 'Continue'
    Then I am on the 'Please select your customer sector' page
    And I select 'Health' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Legal services requiring a deep understanding of the transport, rail, highways, maritime, ports aviation and planning industry' for 'requirements'
    And I click on 'Continue'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    When I check the following items:
      | Competition Law        |
      | Employment Law         |
      | Highways Law           |
      | Maritime and Shipping  |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 5 - Transport and Planning'
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | DONNELLY, DICKINSON AND ABBOTT         | http://donnellydickinsonandabbott.test/mickey.borer |
      | RODRIGUEZ GROUP                        | http://rodriguezgroup.test/ashleigh                 |
      | STROMAN, NOLAN AND LOCKMAN             | http://stromannolanandlockman.test/brenton_schuppe  |
      | SCHNEIDER-BRUEN SME                    | http://schneider-bruen.example/morton_turcotte      |
      | LEMKE, JOHNS AND KUTCH                 | http://lemkejohnsandkutch.example/ellsworth         |
      | SCHNEIDER, ARMSTRONG AND ABERNATHY SME | http://schneiderarmstrongandabernathy.test/elvera   |
      | BROWN, JOHNSTON AND SHANAHAN           | http://brownjohnstonandshanahan.test/tula           |
  Scenario: Service selection changes the results
    Given I click on the 'Back' back link
    Then I am on the 'Select the jurisdiction you need' page
    Given I click on the 'Back' back link
    Then I am on the 'Select legal services required' page
    And I deselect all the items
    Given I check 'Public Procurement Law'
    When I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 5 - Transport and Planning'
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '8' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | SCHNEIDER, ARMSTRONG AND ABERNATHY SME | http://schneiderarmstrongandabernathy.test/elvera   |
      | BROWN, JOHNSTON AND SHANAHAN           | http://brownjohnstonandshanahan.test/tula           |
      | SENGER, MUELLER AND WIEGAND SME        | http://sengermuellerandwiegand.example/elma.dach    |
      | RODRIGUEZ GROUP                        | http://rodriguezgroup.test/ashleigh                 |
      | DONNELLY, DICKINSON AND ABBOTT         | http://donnellydickinsonandabbott.test/mickey.borer |
      | SCHNEIDER-BRUEN SME                    | http://schneider-bruen.example/morton_turcotte      |
      | LEMKE, JOHNS AND KUTCH                 | http://lemkejohnsandkutch.example/ellsworth         |
      | STROMAN, NOLAN AND LOCKMAN             | http://stromannolanandlockman.test/brenton_schuppe  |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then the spreadsheet 'Shortlist of Legal Services Suppliers.xlsx' is downloaded
