@pipeline
Feature: Legal services - Jounrey validations

  Background: Navigate to start page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
  
  Scenario: Do you work for central government validation
    Given I am on the 'Do you work for central government?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you work for central government |

  Scenario: Do you work for central government validation
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if the fees will be under £20,000  |

  Scenario: Select the legal services you need validation
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Select the regions you need validation
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check the following items:
      | Litigation / dispute resolution |
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the region or regions you require the services in  |

  Scenario: Select the regions you need with more than full national coverage validation
    Given I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check the following items:
      | Litigation / dispute resolution |
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    And I check the following items:
      | North East              |
      | Full national coverage  |
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select full national coverage or the region or regions you require the services in  |

  Scenario: Select the lot you need validation
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the lot you need |

  Scenario: Lot 1 - Select the legal services you need validation
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |

  Scenario: Lot 1 - Select the regions where you need legal services validation
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I check the following items:
      | Child law |
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the region or regions you require the services in  |

  Scenario: Lot 2 - Select the jurisdiction you need validation
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the jurisdiction you need  |

  Scenario: Lot 2 - Select the legal services you need' validation
    Given I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal service |
