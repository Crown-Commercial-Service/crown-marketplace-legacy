Feature: Management Consultancy - Admin - Supplier lot data - Lot 6 - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VANDERVORT, KOVACEK AND MORAR'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And I click on 'View rates' for the lot 'Lot 6 - Procurement and Supply Chain'
    Then I am on the 'Lot 6 - Procurement and Supply Chain - Rates' page
    And the caption is 'VANDERVORT, KOVACEK AND MORAR'
    And the rates in the table are:
      | Position                                              | Max day rate |
      | Analyst / Junior Consultant                           | £6           |
      | Consultant                                            | £8           |
      | Senior Consultant / Engagement Manager / Project Lead | £10          |
      | Principal Consultant / Associate Director             | £12          |
      | Managing Consultant / Director                        | £14          |
      | Partner                                               | £16          |
