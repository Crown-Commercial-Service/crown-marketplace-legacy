Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 3 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SANFORD INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SANFORD INC'
    And I click on 'View rates' for the lot 'Lot 3 - Finance and High Risk/Innovation'
    Then I am on the 'Lot 3 - Finance and High Risk/Innovation - Rates' page
    And the caption is 'SANFORD INC'
    And the rates in the 'United Kingdom' table are:
      | Position                                                           | Hourly  |
      | Partner                                                            | £280.00 |
      | Legal Director/Counsel or equivalent                               | £245.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £210.00 |
      | Solicitor, Associate/Legal Executive                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £140.00 |
      | Trainee/Legal Apprentice                                           | £84.00  |
      | Paralegal, Legal Assistant                                         | £70.00  |
