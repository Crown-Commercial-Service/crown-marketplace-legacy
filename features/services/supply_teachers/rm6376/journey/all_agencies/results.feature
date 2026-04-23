@javascript
Feature: Supply Teachers - All agencies

  Background: Navigate to all agenices
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'Find an agency' page
    And a list of 15 agencies are shown
    And the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |

  Scenario: All agencies search agency name
    And I enter "an" for the agency name search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | GRADY AND SONS             |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
    And I enter "" for the agency name search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |

  @geocode_london
  Scenario: All agencies search agency postcode
    And I enter "SW1A 1AA" for the agency postcode search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | HEANEY GROUP               |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |
    And I enter "" for the agency postcode search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |

  @geocode_birmingham
  Scenario: All agencies search agency name and postcode
    And I enter "an" for the agency name search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | GRADY AND SONS             |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
    And I enter "B6 6HE" for the agency postcode search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | GRADY AND SONS             |
      | HEANEY GROUP               |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
    And I enter "" for the agency postcode search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | GRADY AND SONS             |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
    And I enter "" for the agency name search
    Then the listed agencies for all agencies are:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |
