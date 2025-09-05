Feature: Legal Panel for Government - Jounrey validations

  Background: Navigate to start page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'

  Scenario: Do you work for central government validation
    Given I am on the 'Do you work for central government?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you work for central government |

  Scenario: Select the lot you need validations - central government yes
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the lot you need |

  Scenario: Select the legal services you need - not Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Is your requirement for a location outside of the countries listed below?
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select if your requirement is for a country outside the listed locations |

  Scenario: Select the countries for your requirement
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the countries for your requirement |

  Scenario: Select the legal services you need - Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Select suppliers for comparison - not Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check 'Children and Vulnerable Adults'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - one supplier - not Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check 'Children and Vulnerable Adults'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I check 'CORMIER INC'
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check 'Assimilated Law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - one supplier - Lot 4
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check 'Assimilated Law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I check 'CROOKS AND SONS'
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |
