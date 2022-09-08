@pipeline
Feature: Supply Teachers - All agencies - suppliers

  Background: Navigate to the All agencies page 
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'Find an agency' page
    And a list of 10 agencies are shown

  Scenario Outline: Can view supplier details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the branches are:
      | <branch_1>  |
      | <branch_2>  |
    And I click on 'Back'
    Then I am on the 'Find an agency' page

  Examples:
    | agency_name               | branch_1  | branch_2        |
    | CORKERY INC               | Liverpool |Southend-on-Sea  |
    | FEEST-MULLER              | Liverpool | London          |
    | STANTON, FADEL AND BOSCO  | Liverpool | Twickenham      |

  Scenario: Supplier details are correct
    Given I click on 'EMARD AND SONS'
    Then I am on the 'EMARD AND SONS' page
    And the sub title is Agency details
    And the agency has the following rates:
      | Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)                           | £58.35  | £55.43  |
      | Educational Support Staff: (incl. Cover Supervisor, Teaching Assistants)              | £52.51  | £49.88  |
      | Senior Roles: Headteacher and Senior Leadership positions                             | £64.18  | £60.97  |
      | Other Roles: (Invigilators, Admin & Clerical, IT Staff, Finance Staff, Cleaners etc.) | £55.43  | £52.65  |
      | Over 12 Week Reduction                                                                | 3.0%    | 3.0%    |
      | Nominated Worker                                                                      | £46.68  | £46.68  |
      | Fixed Term                                                                            | 35.0%   | 35.0%   |
    And the 'Branch' is 'Liverpool - Merseyside' for the 'Liverpool' branch
    And the 'Contact name' is 'Patricia Bashirian CPA' for the 'Liverpool' branch
    And the 'Contact email' is 'bashirian.patricia.cpa@kris.com' for the 'Liverpool' branch
    And the 'Phone number' is '(988) 509-0891 x8277' for the 'Liverpool' branch
    And the address for the 'Liverpool' branch is:
      | Anfield     |
      | Anfield Rd  |
      | Liverpool   |
      | Merseyside  |
      | L4 0TH      |
