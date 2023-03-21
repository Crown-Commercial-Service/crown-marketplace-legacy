Feature: Legal services - Jounrey validations

  Background: Navigate to start page
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
  
  Scenario: Do you work for central government validation
    Given I am on the 'Do you work for central government?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you work for central government |

  Scenario: Is this service suitable for your requirements validation
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if your requirements allow you to continue |

  Scenario: Select the lot you need validations - central government yes
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the lot you need |

  Scenario: Select the lot you need validations - central government no
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the lot you need |
  
  Scenario: Select the legal services you need - central government yes
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Select the legal services you need - central government no
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Select the jurisdiction you need - central government yes
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you hold an approval secured from the Government Legal Department (GLD) to use this framework?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check the following items:
      | Education Law |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the jurisdiction you need |

  Scenario: Select the jurisdiction you need - central government no
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check the following items:
      | Administrative and Public Law |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the jurisdiction you need |
