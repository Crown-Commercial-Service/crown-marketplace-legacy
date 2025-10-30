Feature: Legal services - Admin - Supplier lot data - Lot 1b - View rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MERTZ-HOMENICK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MERTZ-HOMENICK'
    And I click on 'View rates' for the lot 'Lot 1b - Full service provision (Scotland)'
    Then I am on the 'Lot 1b - Full service provision View rates' page
    And the caption is 'MERTZ-HOMENICK'
    And the rates in the table are:
      | Position                                           | Hourly  |
      | Partner                                            | £175.00 |
      | Senior Solicitor, Senior Associate                 | £150.00 |
      | Solicitor, Associate                               | £125.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate | £100.00 |
      | Trainee                                            | £75.00  |
      | Paralegal, Legal Assistant                         | £50.00  |
      | LMP (Legal project manager)                        | £137.50 |
