@pipeline
Feature: Legal services - Lot 2 - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is 'Lot 2 - Full-service firms'
    And I should see that '5' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | SCHMITT INC                     |

  Scenario: Check the supplier data - SME
    Given I click on 'HETTINGER, BOSCO AND LANGWORTH'
    Then I am on the 'HETTINGER, BOSCO AND LANGWORTH' page
    Then the supplier 'is' an SME
    And the 'Partner including Managing Partner' rates are '£200.00', '£1,260.00' and '£25,200.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£175.00', '£1,102.50' and '£22,050.00'
    And the 'Solicitor/Associate' rates are '£150.00', '£945.00' and '£18,900.00'
    And the 'Junior Solicitor' rates are '£100.00', '£630.00' and '£12,600.00'
    And the 'Trainee/Paralegal' rates are '£50.00', '£315.00' and '£6,300.00'
    And the contact details for the supplier are:
      | langworth.bosco.and.hettinger@hahn.io           |
      | (550) 416-7674 x50810                           |
      | http://hane.name/danial.mcclure                 |
      | 60011 Marcelino Bridge, North Antone, GA 75280  |

  Scenario: Check the supplier data - Non SME
    Given I click on 'HANSEN, MORISSETTE AND ONDRICKA'
    Then I am on the 'HANSEN, MORISSETTE AND ONDRICKA' page
    Then the supplier 'is not' an SME
    And the 'Partner including Managing Partner' rates are '£200.00', '£1,240.00' and '£24,800.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£175.00', '£1,085.00' and '£21,700.00'
    And the 'Solicitor/Associate' rates are '£150.00', '£930.00' and '£18,600.00'
    And the 'Junior Solicitor' rates are '£100.00', '£620.00' and '£12,400.00'
    And the 'Trainee/Paralegal' rates are '£50.00', '£310.00' and '£6,200.00'
    And the contact details for the supplier are:
      | ondricka.hansen.and.morissette@wilkinson.com    |
      | (327) 602-3720 x37548                           |
      | http://shields-okeefe.name/tommy                |
      | 20646 Monroe Bypass, West Art, MD 34854-9760    |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
