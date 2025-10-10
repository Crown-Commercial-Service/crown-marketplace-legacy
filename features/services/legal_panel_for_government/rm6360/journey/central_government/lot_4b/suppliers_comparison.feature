Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Suppliers comparison

  Background: Navigate to start page and complete the journey
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
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | ERDMAN INC               | http://mosciski.example/madelaine      |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | ERDMAN INC               |
      | SANFORD INC              |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison

  Scenario: The rates table is displayed for comparison
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     | £125.00        | £100.00                                                          | £150.00                                                | £125.00                                              |
      | ERDMAN INC               | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |                |                                                                  |                                                        |                                                      |
      | SANFORD INC              | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |

  Scenario: Changing selection changes the results
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And I deselect all the items
    When I check the following items:
      | SANFORD INC            |
      | VEUM, TORPHY AND NOLAN |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '2' suppliers have been selected for comparison
    Then I should see the rates in the comparison table:
      | Supplier               | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | SANFORD INC            | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | VEUM, TORPHY AND NOLAN | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |

  Scenario: Back to results
    When I click on 'Back to results'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal services for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://gleichner-lowe.example/freddie  |
      | ERDMAN INC               | http://mosciski.example/madelaine      |
      | SANFORD INC              | http://murazik-bechtelar.test/neda     |
      | VEUM, TORPHY AND NOLAN   | http://gislason-murazik.example/dorthy |
