Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 5 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WALKER-LEUSCHKE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WALKER-LEUSCHKE'
    And I click on 'View rates' for the lot 'Lot 5 - Rail Legal Services'
    Then I am on the 'Lot 5 - Rail Legal Services - Rates' page
    And the caption is 'WALKER-LEUSCHKE'
    And the rates in the 'United Kingdom' table are:
      | Grade                                                              | Hourly  |
      | Partner                                                            | £280.00 |
      | Legal Director/Counsel or equivalent                               | £245.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £210.00 |
      | Solicitor, Associate/Legal Executive                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £140.00 |
      | Trainee/Legal Apprentice                                           | £84.00  |
      | Paralegal, Legal Assistant                                         | £70.00  |
