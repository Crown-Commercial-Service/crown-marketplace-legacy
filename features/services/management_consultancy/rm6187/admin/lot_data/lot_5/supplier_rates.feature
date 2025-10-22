Feature: Management Consultancy - Admin - Supplier lot data - Lot 5 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BOSCO-EBERT'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOSCO-EBERT'
    And I click on 'View rates' for the lot 'Lot 5 - HR'
    Then I am on the 'Lot 5 - HR - Rates' page
    And the caption is 'BOSCO-EBERT'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £6           |
      | Consultant                                            | £8           |
      | Senior Consultant / Engagement Manager / Project Lead | £10          |
      | Principal Consultant / Associate Director             | £12          |
      | Managing Consultant / Director                        | £14          |
      | Partner                                               | £16          |
