Feature: Supply Teachers - All agencies

  Scenario: All agencies results
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'All agencies' page
    And a list of 20 agencies are shown
    And the listed agencies for 'all agencies' are:
      | BARTOLETTI, KOEPP AND NIENOW  | London          |
      | BARTOLETTI, KOEPP AND NIENOW  | Southport       |
      | CORKERY INC                   | Southend-on-Sea |
      | CORKERY INC                   | Liverpool       |
      | DIETRICH-BORER                | London          |
      | DIETRICH-BORER                | Southport       |
      | EMARD AND SONS                | Twickenham      |
      | EMARD AND SONS                | Liverpool       |
      | FEEST-MULLER                  | London          |
      | FEEST-MULLER                  | Liverpool       |
      | HAGENES-BECHTELAR             | London          |
      | HAGENES-BECHTELAR             | Manchester      |
      | KERLUKE, TORP AND HEATHCOTE   | Southend-on-Sea |
      | KERLUKE, TORP AND HEATHCOTE   | Liverpool       |
      | MCGLYNN GROUP                 | London          |
      | MCGLYNN GROUP                 | Manchester      |
      | STANTON, FADEL AND BOSCO      | Twickenham      |
      | STANTON, FADEL AND BOSCO      | Liverpool       |
      | ZIEMANN-HERMANN               | London          |
      | ZIEMANN-HERMANN               | Liverpool       |
