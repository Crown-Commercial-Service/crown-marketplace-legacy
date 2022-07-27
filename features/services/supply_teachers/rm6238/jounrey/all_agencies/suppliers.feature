@pipeline
Feature: Supply Teachers - All agencies - suppliers

  Background: Navigate to the All agencies page 
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'All agencies' page
    And a list of 20 agencies are shown

  Scenario Outline: Can view supplier details
    Given I click on the supplier '<agency_name>' and it's branch '<branch>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the 'Branch' is '<branch>'
    And I click on 'Back'
    Then I am on the 'All agencies' page

  Examples:
    | agency_name               | branch          |
    | CORKERY INC               | Southend-on-Sea |
    | CORKERY INC               | Liverpool       |
    | FEEST-MULLER              | London          |
    | HAGENES-BECHTELAR         | Manchester      |
    | STANTON, FADEL AND BOSCO  | Liverpool       |

  Scenario: Supplier details are correct
    Given I click on the supplier 'EMARD AND SONS' and it's branch 'Liverpool'
    Then I am on the 'EMARD AND SONS' page
    And the sub title is Agency details
    And the 'Branch' is 'Liverpool'
    And the 'Region' is 'Merseyside'
    And the 'Contact name' is 'Patricia Bashirian CPA'
    And the 'Contact email' is 'bashirian.patricia.cpa@kris.com'
    And the 'Phone number' is '(988) 509-0891 x8277'
    And the address is:
      | Anfield     |
      | Anfield Rd  |
      | Liverpool   |
      | Merseyside  |
      | L4 0TH      |
    And the agency has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £58.35  | £55.43  |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £52.51  | £49.88  |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £64.18  | £60.97  |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £55.43  | £52.65  |
      | Over 12 Week Reduction                                                                | 3.0%    | £233.40 |
      | A specific person                                                                     | £46.68  | £46.68  |
      | Employed directly                                                                     | 35.0%   | 35.0%   |
