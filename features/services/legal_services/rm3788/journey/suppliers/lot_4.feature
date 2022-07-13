Feature: Legal services - Lot 4 - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4 - Transport rail'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is 'Lot 4 - Transport rail'
    And I should see that '10' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BAHRINGER-HUDSON                |
      | BORER-PREDOVIC                  |
      | DOUGLAS AND SONS                |
      | GLOVER, BERGSTROM AND PACOCHA   |
      | GREEN, WALKER AND LEMKE         |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HEGMANN LLC                     |
      | MURAZIK-COLLINS                 |
      | RICE-PROHASKA                   |
      | WALKER, BATZ AND FEENEY         |

  Scenario: Check the supplier data - SME
    Given I click on 'RICE-PROHASKA'
    Then I am on the 'RICE-PROHASKA' page
    Then the supplier 'is' an SME
    And the 'Partner including Managing Partner' rates are '£180.00', '£1,180.00' and '£23,600.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£157.50', '£1,032.50' and '£20,650.00'
    And the 'Solicitor/Associate' rates are '£135.00', '£885.00' and '£17,700.00'
    And the 'Junior Solicitor' rates are '£90.00', '£590.00' and '£11,800.00'
    And the 'Trainee/Paralegal' rates are '£45.00', '£295.00' and '£5,900.00'
    And the contact details for the supplier are:
      | rice_prohaska@brakus.net                                    |
      | 769-741-1119 x919                                           |
      | http://grant.com/nicki.jacobs                               |
      | Apt. 772 6110 Domenic Mountains, East Lauri, SC 53568-9673  |

  @pipeline
  Scenario: Check the supplier data - Non SME
    Given I click on 'BORER-PREDOVIC'
    Then I am on the 'BORER-PREDOVIC' page
    Then the supplier 'is not' an SME
    And the 'Partner including Managing Partner' rates are '£220.00', '£1,360.00' and '£27,200.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£192.50', '£1,190.00' and '£23,800.00'
    And the 'Solicitor/Associate' rates are '£165.00', '£1,020.00' and '£20,400.00'
    And the 'Junior Solicitor' rates are '£110.00', '£680.00' and '£13,600.00'
    And the 'Trainee/Paralegal' rates are '£55.00', '£340.00' and '£6,800.00'
    And the contact details for the supplier are:
      | borer.predovic@leuschke.org                   |
      | 1-975-589-7583 x5467                          |
      | http://littel.co/marquitta                    |
      | 64998 Jackelyn Points, Goldnerberg, MS 67736  |

  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
