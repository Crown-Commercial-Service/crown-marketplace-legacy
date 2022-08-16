@pipeline
Feature: Supply Teachers - All agencies - suppliers

  Background: Navigate to the All agencies page 
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'All agencies' page
    And a list of 10 agencies are shown

  Scenario Outline: Can view supplier details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the branches are:
      | <branch_1>  |
      | <branch_2>  |
    And I click on 'Back'
    Then I am on the 'All agencies' page

  Examples:
    | agency_name                   | branch_1  | branch_2        |
    | CREMIN, SCHUSTER AND LUBOWITZ | Liverpool | Southend-on-Sea |
    | NIKOLAUS AND SONS             | London    | Manchester      |
    | PFANNERSTILL-KUTCH            | London    |Manchester       |

  Scenario: Supplier details are correct
    Given I click on 'BOSCO INC'
    Then I am on the 'BOSCO INC' page
    And the sub title is Agency details
    And the agency has the following rates:
      | Qualified teacher: SEN roles                                                              | 21.5% | 20.4% | 19.3% |
      | Educational support staff: SEN roles (including cover supervisor and teaching assistant)  | 26.6% | 25.2% | 23.9% |
      | Unqualified teacher: non-SEN roles                                                        | 26.6% | 25.2% | 23.9% |
      | Employed directly                                                                         | 13.3% | 13.3% | 13.3% |
      | A specific person                                                                         | 13.3% | 13.3% | 13.3% |
    And the 'Branch' is 'Liverpool - Merseyside' for the 'Liverpool' branch
    And the 'Contact name' is 'Miss Emanuel Jerde' for the 'Liverpool' branch
    And the 'Contact email' is 'emanuel.jerde.miss@ritchie-cruickshank.info' for the 'Liverpool' branch
    And the 'Phone number' is '1-327-673-9781' for the 'Liverpool' branch
    And the address for the 'Liverpool' branch is:
      | Anfield     |
      | Anfield Rd  |
      | Liverpool   |
      | Merseyside  |
      | L4 0TH      |
