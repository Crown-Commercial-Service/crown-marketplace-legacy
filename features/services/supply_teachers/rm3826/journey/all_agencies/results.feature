@pipeline @javascript
Feature: Supply Teachers - All agencies

  Scenario: All agencies search
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'Find an agency' page
    And a list of 10 agencies are shown
    And the listed agencies for all agencies are:
      | BEATTY-DICKENS                |
      | BOSCO INC                     |
      | CREMIN, SCHUSTER AND LUBOWITZ |
      | JOHNS, GLEASON AND WHITE      |
      | KULAS-OKUNEVA                 |
      | MOSCISKI-ROHAN                |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | PFANNERSTILL-KUTCH            |
      | VANDERVORT, CRONA AND TRANTOW |
    And I enter "an" for the agency search
    Then the listed agencies for all agencies are:
      | CREMIN, SCHUSTER AND LUBOWITZ |
      | JOHNS, GLEASON AND WHITE      |
      | MOSCISKI-ROHAN                |
      | NIKOLAUS AND SONS             |
      | PFANNERSTILL-KUTCH            |
      | VANDERVORT, CRONA AND TRANTOW |
    And I enter "" for the agency search
    Then the listed agencies for all agencies are:
      | BEATTY-DICKENS                |
      | BOSCO INC                     |
      | CREMIN, SCHUSTER AND LUBOWITZ |
      | JOHNS, GLEASON AND WHITE      |
      | KULAS-OKUNEVA                 |
      | MOSCISKI-ROHAN                |
      | NIKOLAUS AND SONS             |
      | PAGAC INC                     |
      | PFANNERSTILL-KUTCH            |
      | VANDERVORT, CRONA AND TRANTOW |
