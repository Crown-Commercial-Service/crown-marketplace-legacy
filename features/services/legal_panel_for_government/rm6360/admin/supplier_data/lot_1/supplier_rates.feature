Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 1 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BALISTRERI-MURAZIK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BALISTRERI-MURAZIK'
    And I click on 'View rates' for the lot 'Lot 1 - Core Legal Services'
    Then I am on the 'Lot 1 - Core Legal Services - Rates' page
    And the caption is 'BALISTRERI-MURAZIK'
    And the rates in the 'United Kingdom' table are:
      | Position                                                           | Hourly  |
      | Partner                                                            | £200.00 |
      | Legal Director/Counsel or equivalent                               | £175.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £150.00 |
      | Solicitor, Associate/Legal Executive                               | £125.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £100.00 |
      | Trainee/Legal Apprentice                                           | £60.00  |
      | Paralegal, Legal Assistant                                         | £50.00  |
