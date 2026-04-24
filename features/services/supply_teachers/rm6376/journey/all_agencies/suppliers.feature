Feature: Supply Teachers - All agencies - suppliers

  Background: Navigate to the All agencies page
    Given I sign in and navigate to the start page for the 'RM6376' framework in 'supply teachers'
    And I select "A list of all agencies"
    And I click on 'Continue'
    Then I am on the 'Find an agency' page
    And a list of 15 agencies are shown

  Scenario Outline: Can view supplier details
    Given I click on '<agency_name>'
    Then I am on the '<agency_name>' page
    And the sub title is Agency details
    And the branches are:
      | <branch_1> |
      | <branch_2> |
      | <branch_3> |
    And I click on 'Back'
    Then I am on the 'Find an agency' page

    Examples:
      | agency_name             | branch_1   | branch_2   | branch_3        |
      | DANIEL AND SONS         | Birmingham | Liverpool  | Twickenham      |
      | NADER, CONN AND REINGER | Liverpool  | Nottingham | Southend-on-Sea |
      | TILLMAN-EMMERICH        | Dudley     | London     | Southport       |

  Scenario: Supplier details are correct
    Given I click on 'HEANEY GROUP'
    Then I am on the 'HEANEY GROUP' page
    And the sub title is Agency details
    And the agency has the following rates:
      | STEM Teacher (Inc. Qualified Teachers, Tutors)                                                           | £66.64 |
      | Non-STEM Teachers (Inc. Qualified Teachers, Tutors)                                                      | £55.54 |
      | Educational Support Staff non SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers) | £38.87 |
      | Educational Support Staff SEND (Inc. Cover Supervisor, Teaching Assistants and unqualified teachers)     | £49.98 |
      | Senior Roles (Inc. Headteacher and Senior Leadership positions)                                          | £66.64 |
      | Facilities Management (Inc. Caretakers, site roles etc)                                                  | £44.43 |
      | Admin & Clerical (Inc. Office Staff, Finance Support)                                                    | £41.65 |
      | Other (Inc. Invigilators, cleaners)                                                                      | £27.77 |
      | Over 12 Week Reduction                                                                                   | 52.8%  |
      | Nominated Workers                                                                                        | 58.3%  |
      | Fixed Term / Permanent Roles (on School Payroll)                                                         | 47.2%  |
    And the 'Branch' is 'Manchester - Greater Manchester' for the 'Manchester' branch
    And the 'Contact name' is 'Rep. Majorie Auer' for the 'Manchester' branch
    And the 'Contact email' is 'auer_rep_majorie@barton-feil.example' for the 'Manchester' branch
    And the 'Phone number' is '028 4232 5477' for the 'Manchester' branch
    And the address for the 'Manchester' branch is:
      | Old Trafford       |
      | Sir Matt Busby Way |
      | Manchester         |
      | Greater Manchester |
      | M16 0RA            |
