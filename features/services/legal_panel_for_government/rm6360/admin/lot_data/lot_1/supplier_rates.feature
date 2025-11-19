Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 1 - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BALISTRERI-MURAZIK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BALISTRERI-MURAZIK'
    And I click on 'View rates' for the lot 'Lot 1 - Core Legal Services'
    Then I am on the 'Lot 1 - Core Legal Services View rates' page
    And the caption is 'BALISTRERI-MURAZIK'
    And the rates in the 'United Kingdom' table are:
      | Grade                                                              | Hourly  |
      | Partner                                                            | £200.00 |
      | Legal Director/Counsel or equivalent                               | £175.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £150.00 |
      | Solicitor, Associate/Legal Executive                               | £125.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £100.00 |
      | Trainee/Legal Apprentice                                           | £60.00  |
      | Paralegal, Legal Assistant                                         | £50.00  |
      | Legal Project Managers                                             | £87.50  |
    Given I click on 'Change (Supplier rates for United Kingdom)'
    Then I am on the 'Edit rates for United Kingdom' page
    And the caption is 'BALISTRERI-MURAZIK'

  Scenario Outline: Rates validation
    Then I enter the following rates into the form:
      | Partner | <rate> |
    And I click on 'Save and return'
    Then I am on the 'Edit rates for United Kingdom' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | rate        | error_message                                            |
      |             | You must enter a value for this rate                     |
      | Not a rate  | The rate must be formatted as money, for example £350.50 |
      | 55.5        | The rate must be formatted as money, for example £350.50 |
      | 10000000.00 | The rate must be less than £1,000,000                    |

  Scenario: Set rates
    Then I enter the following rates into the form:
      | Partner                                                            | 10000.00 |
      | Legal Director/Counsel or equivalent                               | 1000.00  |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | 1000.00  |
      | Solicitor, Associate/Legal Executive                               | 100.90   |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | 123      |
      | Trainee/Legal Apprentice                                           | 456.78   |
      | Paralegal, Legal Assistant                                         | 106      |
      | Legal Project Managers                                             | 405.44   |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Core Legal Services View rates' page
    And the caption is 'BALISTRERI-MURAZIK'
    And the rates in the 'United Kingdom' table are:
      | Grade                                                              | Hourly     |
      | Partner                                                            | £10,000.00 |
      | Legal Director/Counsel or equivalent                               | £1,000.00  |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £1,000.00  |
      | Solicitor, Associate/Legal Executive                               | £100.90    |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £123       |
      | Trainee/Legal Apprentice                                           | £456.78    |
      | Paralegal, Legal Assistant                                         | £106       |
      | Legal Project Managers                                             | £405.44    |
