Feature: Legal services - Lot 3 - Suppliers

  Background: Login and then navigate to the supplier results page
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Property and construction'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And the sub title is 'Lot 3 - Property and construction'
    And I should see that '10' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BAHRINGER-HUDSON                |
      | GREEN, WALKER AND LEMKE         |
      | HALEY, BARTON AND REICHEL       |
      | HANSEN, MORISSETTE AND ONDRICKA |
      | HETTINGER, BOSCO AND LANGWORTH  |
      | JONES-AUFDERHAR                 |
      | MERTZ, LEGROS AND SCHROEDER     |
      | MURAZIK-COLLINS                 |
      | SCHMITT INC                     |
      | WALKER, BATZ AND FEENEY         |

  @pipeline
  Scenario: Check the supplier data - SME
    Given I click on 'GREEN, WALKER AND LEMKE'
    Then I am on the 'GREEN, WALKER AND LEMKE' page
    Then the supplier 'is' an SME
    And the 'Partner including Managing Partner' rates are '£200.00', '£1,200.00' and '£24,000.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£175.00', '£1,050.00' and '£21,000.00'
    And the 'Solicitor/Associate' rates are '£150.00', '£900.00' and '£18,000.00'
    And the 'Junior Solicitor' rates are '£100.00', '£600.00' and '£12,000.00'
    And the 'Trainee/Paralegal' rates are '£50.00', '£300.00' and '£6,000.00'
    And the contact details for the supplier are:
      | lemke.green.and.walker@davis.net                |
      | 660-599-8980 x5204                              |
      | http://champlin.io/renate                       |
      | 53859 Alida Estate, North Darrinstad, HI 36426  |

  Scenario: Check the supplier data - Non SME
    Given I click on 'BAHRINGER-HUDSON'
    Then I am on the 'BAHRINGER-HUDSON' page
    Then the supplier 'is not' an SME
    And the 'Partner including Managing Partner' rates are '£160.00', '£1,060.00' and '£21,200.00'
    And the 'Senior Solicitor/Senior Associate/Legal Director' rates are '£140.00', '£927.50' and '£18,550.00'
    And the 'Solicitor/Associate' rates are '£120.00', '£795.00' and '£15,900.00'
    And the 'Junior Solicitor' rates are '£80.00', '£530.00' and '£10,600.00'
    And the 'Trainee/Paralegal' rates are '£40.00', '£265.00' and '£5,300.00'
    And the contact details for the supplier are:
      | bahringer_hudson@smith-schultz.co               |
      | 687-000-7255 x52836                             |
      | http://bogan.net/joe.halvorson                  |
      | 37347 Gabriel Village, Port Kymberly, WV 53530  |

  @pipeline
  Scenario: Download the supplier spreadsheet
    Given I click on 'Download the supplier list'
    Then I am on the 'Download the supplier shortlist' page
    And I click on 'Download supplier shortlist'
    Then the spreadsheet 'Shortlist of WPS Legal Services Suppliers.xlsx' is downloaded
