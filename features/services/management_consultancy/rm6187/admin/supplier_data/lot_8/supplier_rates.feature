Feature: Management Consultancy - Admin - Supplier lot data - Lot 8 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WILLIAMSON, DOYLE AND GLOVER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And I click on 'View rates' for the lot 'Lot 8 - Infrastructure including Transport'
    Then I am on the 'Lot 8 - Infrastructure including Transport - Rates' page
    And the caption is 'WILLIAMSON, DOYLE AND GLOVER'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £4           |
      | Consultant                                            | £6           |
      | Senior Consultant / Engagement Manager / Project Lead | £8           |
      | Principal Consultant / Associate Director             | £10          |
      | Managing Consultant / Director                        | £12          |
      | Partner                                               | £14          |
