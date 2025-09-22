@geocode_london
Feature: Supply Teachers - Agency results - Nominated worker - Agencies

  Background: Navigate to the Agency results page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
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
    And there are 8 agencies
    And the listed agencies with rates and distances are:
      | BARTOLETTI, KOEPP AND NIENOW | London     | £22.07 | 6.0 |
      | MCGLYNN GROUP                | London     | £31.87 | 5.2 |
      | STANTON, FADEL AND BOSCO     | Twickenham | £33.16 | 9.0 |
      | DIETRICH-BORER               | London     | £34.12 | 6.0 |
      | HAGENES-BECHTELAR            | London     | £39.98 | 5.2 |
      | ZIEMANN-HERMANN              | London     | £42.85 | 0.2 |
      | EMARD AND SONS               | Twickenham | £46.68 | 9.0 |
      | FEEST-MULLER                 | London     | £47.64 | 0.2 |

  Scenario Outline: I can naviagte to the agency details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'

    Examples:
      | agency_name       | branch |
      | MCGLYNN GROUP     | London |
      | HAGENES-BECHTELAR | London |
      | FEEST-MULLER      | London |

  Scenario: I can download the shortlist document
    And I click on 'Download shortlist of agencies'
    Then the spreadsheet 'Shortlist of agencies' is downloaded

  Scenario: Back buttons work
    Given I click on 'STANTON, FADEL AND BOSCO'
    Then I am on the 'STANTON, FADEL AND BOSCO' page
    And the sub title is Agency details
    And the 'Branch' is 'Twickenham'
    Then I click on 'Back'
    Then I am on the 'Agency results' page
    Then I click on 'Back'
    Then I am on the 'What is your school’s postcode?' page
    And I click on 'Continue'
    Then I am on the 'Agency results' page
    And there are 8 agencies
    And the listed agencies for agency results are:
      | BARTOLETTI, KOEPP AND NIENOW | London     |
      | MCGLYNN GROUP                | London     |
      | STANTON, FADEL AND BOSCO     | Twickenham |
      | DIETRICH-BORER               | London     |
      | HAGENES-BECHTELAR            | London     |
      | ZIEMANN-HERMANN              | London     |
      | EMARD AND SONS               | Twickenham |
      | FEEST-MULLER                 | London     |
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
