@pipeline
Feature: Legal services -  Non central governemnt - Lot 2 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'
    When I check the following items:
      | Court of Protection |
      | Licensing           |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - General service provision'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | COLLINS, COLE AND PACOCHA   |
      | GUSIKOWSKI, BOSCO AND CRIST |
      | WILLIAMSON-BERGSTROM        |

  Scenario: Check the supplier data - SME
    Given I click on 'GUSIKOWSKI, BOSCO AND CRIST'
    Then I am on the 'GUSIKOWSKI, BOSCO AND CRIST' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£150.00'
    And the 'Solicitor, Associate' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£100.00'
    And the 'Trainee' hourly rate is '£75.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the contact details for the supplier are:
      | gusikowski.bosco.crist.and@schoen.net             |
      | 555.493.0253 x3505                                |
      | http://orn.co/jessie                              |
      | Suite 667 219 Oren Ranch, Lake Fletcher, RI 32632 |

  Scenario: Check the supplier data - Non SME
    Given I click on 'WILLIAMSON-BERGSTROM'
    Then I am on the 'WILLIAMSON-BERGSTROM' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£245.00'
    And the 'Senior Solicitor, Senior Associate' hourly rate is '£210.00'
    And the 'Solicitor, Associate' hourly rate is '£175.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate' hourly rate is '£140.00'
    And the 'Trainee' hourly rate is '£105.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£70.00'
    And the contact details for the supplier are:
      | williamson_bergstrom@volkman-johnston.name  |
      | (951) 158-9443                              |
      | http://pollich.net/jerold_bauch             |
      | 707 Melida Row, Greenfelderfurt, RI 25780   |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
