Feature: Supply Teachers - All agencies

  Scenario: All agencies results
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'All agencies' page
    And a list of 20 agencies are shown
    And the listed agencies for 'all agencies' are:
      | BEATTY-DICKENS                | London          |
      | BEATTY-DICKENS                | Southport       |
      | BOSCO INC                     | Twickenham      |
      | BOSCO INC                     | Liverpool       |
      | CREMIN, SCHUSTER AND LUBOWITZ | Southend-on-Sea |
      | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool       |
      | JOHNS, GLEASON AND WHITE      | London          |
      | JOHNS, GLEASON AND WHITE      | Liverpool       |
      | KULAS-OKUNEVA                 | Southend-on-Sea |
      | KULAS-OKUNEVA                 | Liverpool       |
      | MOSCISKI-ROHAN                | London          |
      | MOSCISKI-ROHAN                | Liverpool       |
      | NIKOLAUS AND SONS             | London          |
      | NIKOLAUS AND SONS             | Manchester      |
      | PAGAC INC                     | London          |
      | PAGAC INC                     | Southport       |
      | PFANNERSTILL-KUTCH            | London          |
      | PFANNERSTILL-KUTCH            | Manchester      |
      | VANDERVORT, CRONA AND TRANTOW | Twickenham      |
      | VANDERVORT, CRONA AND TRANTOW | Liverpool       |
