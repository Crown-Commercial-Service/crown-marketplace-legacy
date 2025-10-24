Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Suppliers comparison - Countries

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
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Finland     |
      | South Sudan |
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    When I check the following items:
      | Assimilated Law |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Have you reviewed the suppliers’ prospectus to inform your down-selection?' page

  @javascript
  Scenario: Suppliers reviewed - The rates table is displayed for comparison
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on 'Finland'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | CROOKS AND SONS          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | DICKI, QUITZON AND KUB   | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                | £100.00                                                          |                                                        | £125.00                                              |
    And I click on 'South Sudan'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | CROOKS AND SONS          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     | £125.00        | £100.00                                                          | £150.00                                                | £125.00                                              |
      | DICKI, QUITZON AND KUB   | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |                | £120.00                                                          |                                                        | £150.00                                              |

  @javascript
  Scenario: Suppliers not reviewed - The rates table is displayed for comparison
    And I 'have not' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on 'Finland'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | CROOKS AND SONS          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | DICKI, QUITZON AND KUB   | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                | £100.00                                                          |                                                        | £125.00                                              |
      | O'CONNER AND SONS        | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                |                                                                  |                                                        |                                                      |
    And I click on 'South Sudan'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | CROOKS AND SONS          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     | £125.00        | £100.00                                                          | £150.00                                                | £125.00                                              |
      | DICKI, QUITZON AND KUB   | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |                | £120.00                                                          |                                                        | £150.00                                              |
      | O'CONNER AND SONS        | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |                |                                                                  |                                                        |                                                      |

  @javascript
  Scenario: Suppliers reviewed - Changing selection changes the results
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And I deselect all the items
    When I check the following items:
      | O'CONNER AND SONS |
      | STANTON-GOYETTE   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '2' suppliers have been selected for comparison
    And I click on 'Finland'
    Then I should see the rates in the comparison table:
      | Supplier          | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | O'CONNER AND SONS | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE   | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                |                                                                  |                                                        |                                                      |
    And I click on 'South Sudan'
    Then I should see the rates in the comparison table:
      | Supplier          | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | O'CONNER AND SONS | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE   | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |                |                                                                  |                                                        |                                                      |

  Scenario: Suppliers reviewed - Back to results
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    When I click on 'Back to results'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN | http://maggio-gulgowski.test/caridad   |
      | CROOKS AND SONS          | http://von.example/mireille            |
      | DICKI, QUITZON AND KUB   | http://schultz-macgyver.example/edmund |
      | O'CONNER AND SONS        | http://hudson.example/curtis           |
      | STANTON-GOYETTE          | http://lakin.example/lavinia           |

  @javascript
  Scenario: Suppliers reviewed - Going back from a supplier
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on 'CROOKS AND SON' legal panel for governemnt supplier
    Then I am on the 'CROOKS AND SON' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I click on the 'Back' back link
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on 'Finland'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | CROOKS AND SONS          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | DICKI, QUITZON AND KUB   | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                | £100.00                                                          |                                                        | £125.00                                              |
    And I click on 'South Sudan'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | CROOKS AND SONS          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     | £125.00        | £100.00                                                          | £150.00                                                | £125.00                                              |
      | DICKI, QUITZON AND KUB   | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |                | £120.00                                                          |                                                        | £150.00                                              |

  @javascript
  Scenario: Suppliers not reviewed - Going back from a supplier
    And I 'have not' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on 'STANTON-GOYETTE' legal panel for governemnt supplier
    Then I am on the 'STANTON-GOYETTE' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I click on the 'Back' back link
    Then I am on the 'Compare supplier rates' page
    And I click on 'Finland'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | CROOKS AND SONS          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | DICKI, QUITZON AND KUB   | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                | £100.00                                                          |                                                        | £125.00                                              |
      | O'CONNER AND SONS        | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |                |                                                                  |                                                        |                                                      |
    And I click on 'South Sudan'
    Then I should see the rates in the comparison table:
      | Supplier                 | Senior Counsel, Senior Partner (20 years +PQE) | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant | Senior Analyst | Analyst, Associate Analyst, Research Associate, Research Officer | Senior Modeller, Senior Econometrician, Senior Analyst | Modeller, Econometrician, Analyst, Associate Analyst |
      | ADAMS, WOLFF AND STROMAN | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     | £175.00        | £140.00                                                          | £210.00                                                | £175.00                                              |
      | CROOKS AND SONS          | £225.00                                        | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     | £125.00        | £100.00                                                          | £150.00                                                | £125.00                                              |
      | DICKI, QUITZON AND KUB   | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |                | £120.00                                                          |                                                        | £150.00                                              |
      | O'CONNER AND SONS        | £270.00                                        | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     | £150.00        | £120.00                                                          | £180.00                                                | £150.00                                              |
      | STANTON-GOYETTE          | £315.00                                        | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |                |                                                                  |                                                        |                                                      |

  Scenario: Suppliers reviewed - Download the supplier spreadsheet
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | ADAMS, WOLFF AND STROMAN |
      | CROOKS AND SONS          |
      | DICKI, QUITZON AND KUB   |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    Given I click on 'Download the rates for comparison'
    Then the spreadsheet 'Rates of Legal Panel for Government Suppliers.xlsx' is downloaded

  Scenario: Suppliers not reviewed - Download the supplier spreadsheet
    And I 'have not' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    Given I click on 'Download the rates for comparison'
    Then the spreadsheet 'Rates of Legal Panel for Government Suppliers.xlsx' is downloaded
