Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Suppliers comparison selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    When I check the following items:
      | Domestic law of jurisdictions for trade |
      | International trade disputes            |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | ERDMAN INC               | http://mosciski.example/madelaine      |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Have you reviewed the suppliers’ prospectus to inform your down-selection?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    Then I should see the following options for the lot:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
      | VEUM, TORPHY AND NOLAN   |
