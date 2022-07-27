@pipeline
Feature: Legal services - Lot 1 - Non central government - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Will the fees be under £20,000 per matter?' page
    And I select 'Yes'
    When I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Regional service provision'
    Given I select all the services
    And I click on 'Continue'
    Then I am on the 'Select the regions where you need legal services' page
    When I check the following items:
      | Full national coverage  |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services
    And the selected legal service suppliers are:
      | HALEY, BARTON AND REICHEL       |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |

  Scenario: Check the supplier data - SME
    Given I click on 'SCHMITT INC'
    Then I am on the 'SCHMITT INC' page
    Then the supplier 'is' an SME
    And the 'Managing Practitioner' lot 1 rates are '£220.00', '£1,340.00' and '£26,800.00'
    And the 'Senior Practitioner' lot 1 rates are '£192.50', '£1,172.50' and '£23,450.00'
    And the 'Solicitor/Associate' lot 1 rates are '£165.00', '£1,005.00' and '£20,100.00'
    And the 'Legal Support Practitioner/Executive' lot 1 rates are '£110.00', '£670.00' and '£13,400.00'
    And the contact details for the supplier are:
      | schmitt_inc@hilll.org                           |
      | (289) 285-3060 x9117                            |
      | http://luettgen-kris.io/reyes                   |
      | Suite 893 5159 Angelo Pine, Devinfurt, AR 66060 |

  Scenario: Check the supplier data - Non SME
    Given I click on 'JONES-AUFDERHAR'
    Then I am on the 'JONES-AUFDERHAR' page
    Then the supplier 'is not' an SME
    And the 'Managing Practitioner' lot 1 rates are '£220.00', '£1,380.00' and '£27,600.00'
    And the 'Senior Practitioner' lot 1 rates are '£192.50', '£1,207.50' and '£24,150.00'
    And the 'Solicitor/Associate' lot 1 rates are '£165.00', '£1,035.00' and '£20,700.00'
    And the 'Legal Support Practitioner/Executive' lot 1 rates are '£110.00', '£690.00' and '£13,800.00'
    And the contact details for the supplier are:
      | jones.aufderhar@frami.info                            |
      | (618) 058-5867 x502                                   |
      | http://gusikowski.net/santo                           |
      | Apt. 656 14407 Beatty View, Vandervortside, AZ 59990  |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
