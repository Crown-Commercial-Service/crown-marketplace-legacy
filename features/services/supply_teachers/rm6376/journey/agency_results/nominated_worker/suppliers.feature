@geocode_london
Feature: Supply Teachers - Agency results - Nominated worker - Agencies

  Background: Navigate to the Agency results page
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
    And I select 'No, I have a worker I want the agency to manage (a ‘nominated worker’)'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter 'SW1A 1AA' for the 'postcode'
    And I click on 'Continue'
    Then I am on the 'Agency results' page

  Scenario: The agency details shown are correct
    And there are 12 agencies
    And the listed agencies with rates and distances are:
      | ROHAN LLC                  | London     | £32.67 | 0.2 |
      | GLOVER-ONDRICKA            | London     | £35.41 | 0.2 |
      | ROOB, CORWIN AND DICKI     | London     | £41.74 | 5.2 |
      | DANIEL AND SONS            | Twickenham | £52.71 | 9.0 |
      | TREMBLAY-WEST              | London     | £54.20 | 5.2 |
      | ROSENBAUM-HINTZ            | London     | £54.86 | 6.0 |
      | HEANEY GROUP               | London     | £58.31 | 5.2 |
      | DARE-ROHAN                 | Twickenham | £60.19 | 9.0 |
      | FRITSCH-HAHN               | London     | £70.67 | 6.0 |
      | TILLMAN-EMMERICH           | London     | £71.10 | 6.0 |
      | GRADY AND SONS             | London     | £71.59 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham | £72.94 | 9.0 |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

    Examples:
      | agency_name     | branch |
      | GLOVER-ONDRICKA | London |
      | FRITSCH-HAHN    | London |
      | GRADY AND SONS  | London |

  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'DARE-ROHAN'
    Then I am on the 'DARE-ROHAN' page
    And the sub title is Agency details
    And the 'Branch' is 'Twickenham'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'What is your school’s postcode?' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 12 agencies
    And the listed agencies for agency results are:
      | ROHAN LLC                  | London     | £32.67 | 0.2 |
      | GLOVER-ONDRICKA            | London     | £35.41 | 0.2 |
      | ROOB, CORWIN AND DICKI     | London     | £41.74 | 5.2 |
      | DANIEL AND SONS            | Twickenham | £52.71 | 9.0 |
      | TREMBLAY-WEST              | London     | £54.20 | 5.2 |
      | ROSENBAUM-HINTZ            | London     | £54.86 | 6.0 |
      | HEANEY GROUP               | London     | £58.31 | 5.2 |
      | DARE-ROHAN                 | Twickenham | £60.19 | 9.0 |
      | FRITSCH-HAHN               | London     | £70.67 | 6.0 |
      | TILLMAN-EMMERICH           | London     | £71.10 | 6.0 |
      | GRADY AND SONS             | London     | £71.59 | 0.2 |
      | SWANIAWSKI, CORWIN AND KUB | Twickenham | £72.94 | 9.0 |
    Then I click on 'Back'
    And I am on the 'What is your school’s postcode?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    Then I click on 'Back'
    And I am on the 'Do you want an agency to supply the worker?' page
    Then I click on 'Back'
    And I am on the 'What is your school looking for?' page
    And I click on 'Continue'
    And I am on the 'Do you want an agency to supply the worker?' page
