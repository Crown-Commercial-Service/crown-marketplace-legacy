Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Suppliers comparison

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
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 1 - Core Legal Services'
    When I check the following items:
      | Assimilated Law       |
      | Aviation and Airports |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Have you reviewed the suppliers’ prospectus to inform your down-selection?' page

  Scenario: Suppliers reviewed - The rates table is displayed for comparison
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    Then I should see the rates in the comparison table:
      | Supplier                      | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant |
      | CORMIER INC                   | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |
      | GOYETTE AND SONS              | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | LOCKMAN, NITZSCHE AND BARTELL | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |

  Scenario: Suppliers not reviewed - The rates table is displayed for comparison
    And I 'have not' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    Then I should see the rates in the comparison table:
      | Supplier                      | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant |
      | CORMIER INC                   | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |
      | GOYETTE AND SONS              | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | LOCKMAN, NITZSCHE AND BARTELL | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | MONAHAN-JOHNS                 | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |

  Scenario: Suppliers reviewed - Changing selection changes the results
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on the 'Back' back link
    Then I am on the 'Select suppliers for comparison' page
    And I deselect all the items
    When I check the following items:
      | LOCKMAN, NITZSCHE AND BARTELL |
      | MONAHAN-JOHNS                 |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '2' suppliers have been selected for comparison
    Then I should see the rates in the comparison table:
      | Supplier                      | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant |
      | LOCKMAN, NITZSCHE AND BARTELL | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | MONAHAN-JOHNS                 | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |

  Scenario: Suppliers reviewed - Back to results
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    When I click on 'Back to results'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | CORMIER INC                   | http://block.test/blossom.gulgowski |
      | GOYETTE AND SONS              | http://krajcik.example/tisa_kilback |
      | LOCKMAN, NITZSCHE AND BARTELL | http://shanahan.test/natalya_howell |
      | MONAHAN-JOHNS                 | http://kirlin.test/dione.rau        |

  Scenario: Suppliers reviewed - Going back from a supplier
    And I 'have' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Select suppliers for comparison' page
    When I check the following items:
      | CORMIER INC                   |
      | GOYETTE AND SONS              |
      | LOCKMAN, NITZSCHE AND BARTELL |
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    And I click on 'CORMIER INC'
    Then I am on the 'CORMIER INC' page
    And the sub title is 'Lot 1 - Core Legal Services'
    And I click on the 'Back' back link
    Then I am on the 'Compare supplier rates' page
    And I should see that '3' suppliers have been selected for comparison
    Then I should see the rates in the comparison table:
      | Supplier                      | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant |
      | CORMIER INC                   | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |
      | GOYETTE AND SONS              | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | LOCKMAN, NITZSCHE AND BARTELL | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |

  Scenario: Suppliers not reviewed - Going back from a supplier
    And I 'have not' reviewed the suppliers’ prospectus
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    And I click on 'CORMIER INC'
    Then I am on the 'CORMIER INC' page
    And the sub title is 'Lot 1 - Core Legal Services'
    And I click on the 'Back' back link
    Then I am on the 'Compare supplier rates' page
    Then I should see the rates in the comparison table:
      | Supplier                      | Partner | Legal Director/Counsel or equivalent | Senior Solicitor, Senior Associate/Senior Legal Executive | Solicitor, Associate/Legal Executive | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | Trainee/Legal Apprentice | Paralegal, Legal Assistant |
      | CORMIER INC                   | £240.00 | £210.00                              | £180.00                                                   | £150.00                              | £120.00                                                            | £72.00                   | £60.00                     |
      | GOYETTE AND SONS              | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | LOCKMAN, NITZSCHE AND BARTELL | £280.00 | £245.00                              | £210.00                                                   | £175.00                              | £140.00                                                            | £84.00                   | £70.00                     |
      | MONAHAN-JOHNS                 | £200.00 | £175.00                              | £150.00                                                   | £125.00                              | £100.00                                                            | £60.00                   | £50.00                     |
