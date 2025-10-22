Feature: Legal services - Admin - Supplier lot data - Lot 1a - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'LEDNER, BAILEY AND WEISSNAT'
    Then I am on the 'Supplier lot data' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And I click on 'View rates' for the lot 'Lot 1a - Full service provision (England and Wales)'
    Then I am on the 'Lot 1a - Full service provision - Rates' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And the rates in the table are:
      | Position                                           | Hourly  |
      | Partner                                            | £245.00 |
      | Senior Solicitor, Senior Associate                 | £210.00 |
      | Solicitor, Associate                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate | £140.00 |
      | Trainee                                            | £105.00 |
      | Paralegal, Legal Assistant                         | £70.00  |
