Feature: Management Consultancy - Admin - Supplier lot data - Lot 1 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREMBLAY-MOORE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREMBLAY-MOORE'
    And I click on 'View rates' for the lot 'Lot 1 - Business'
    Then I am on the 'Lot 1 - Business - Rates' page
    And the caption is 'TREMBLAY-MOORE'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £6           |
      | Consultant                                            | £8           |
      | Senior Consultant / Engagement Manager / Project Lead | £10          |
      | Principal Consultant / Associate Director             | £12          |
      | Managing Consultant / Director                        | £14          |
      | Partner                                               | £16          |
