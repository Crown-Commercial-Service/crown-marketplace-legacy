Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 2 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CORMIER INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CORMIER INC'
    And I click on 'View rates' for the lot 'Lot 2 - Major Projects and Complex Advice'
    Then I am on the 'Lot 2 - Major Projects and Complex Advice - Rates' page
    And the caption is 'CORMIER INC'
    And the rates in the 'United Kingdom' table are:
      | Grade                                                              | Hourly  |
      | Partner                                                            | £200.00 |
      | Legal Director/Counsel or equivalent                               | £175.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £150.00 |
      | Solicitor, Associate/Legal Executive                               | £125.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £100.00 |
      | Trainee/Legal Apprentice                                           | £60.00  |
      | Paralegal, Legal Assistant                                         | £50.00  |
