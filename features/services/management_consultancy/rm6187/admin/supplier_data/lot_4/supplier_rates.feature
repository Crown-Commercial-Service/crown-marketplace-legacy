Feature: Management Consultancy - Admin - Supplier lot data - Lot 4 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM-RODRIGUEZ'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM-RODRIGUEZ'
    And I click on 'View rates' for the lot 'Lot 4 - Finance'
    Then I am on the 'Lot 4 - Finance - Rates' page
    And the caption is 'VEUM-RODRIGUEZ'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £5           |
      | Consultant                                            | £7           |
      | Senior Consultant / Engagement Manager / Project Lead | £9           |
      | Principal Consultant / Associate Director             | £11          |
      | Managing Consultant / Director                        | £13          |
      | Partner                                               | £15          |
