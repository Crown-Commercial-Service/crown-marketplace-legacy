@pipeline
Feature: Legal services - Lot 1 - Non central government - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Regional service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Full national coverage  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '3' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Check the supplier data - SME
    Given I click on 'HETTINGER, BOSCO AND LANGWORTH'
    Then I am on the 'HETTINGER, BOSCO AND LANGWORTH' page
    Then the supplier 'is' an SME
    And the 'Managing Practitioner' lot 1 rates are '£200.00', '£1,260.00' and '£25,200.00'
    And the 'Senior Practitioner' lot 1 rates are '£175.00', '£1,102.50' and '£22,050.00'
    And the 'Solicitor/Associate' lot 1 rates are '£150.00', '£945.00' and '£18,900.00'
    And the 'Legal Support Practitioner/Executive' lot 1 rates are '£100.00', '£630.00' and '£12,600.00'
    And the contact details for the supplier are:
      | langworth.bosco.and.hettinger@hahn.io           |
      | (550) 416-7674 x50810                           |
      | http://hane.name/danial.mcclure                 |
      | 60011 Marcelino Bridge, North Antone, GA 75280  |

  Scenario: Check the supplier data - Non SME
    Given I click on 'MURAZIK-COLLINS'
    Then I am on the 'MURAZIK-COLLINS' page
    Then the supplier 'is not' an SME
    And the 'Managing Practitioner' lot 1 rates are '£200.00', '£1,220.00' and '£24,400.00'
    And the 'Senior Practitioner' lot 1 rates are '£175.00', '£1,067.50' and '£21,350.00'
    And the 'Solicitor/Associate' lot 1 rates are '£150.00', '£915.00' and '£18,300.00'
    And the 'Legal Support Practitioner/Executive' lot 1 rates are '£100.00', '£610.00' and '£12,200.00'
    And the contact details for the supplier are:
      | collins_murazik@torp.com                              |
      | 1-486-953-4400 x525                                   |
      | http://watsica-roob.org/melina                        |
      | Apt. 709 4791 Fernando Bypass, Lelandmouth, MI 75076  |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
