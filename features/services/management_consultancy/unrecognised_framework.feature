Feature: Management Consultancy - Start pages - With an unrecognised framework

  Scenario: Go to unrecognised famework in the buyer section - logged in
    When I go to the 'management consultancy' start page for 'RM007'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM007'
    And I click on 'RM6187'
    Then I am on the 'Find management consultants' page
    And the framework is 'RM6187'

  Scenario: Go to unrecognised famework in the buyer section - logged out
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    And I go to the 'management consultancy' start page for 'RM9812'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM9812'
    And I click on 'RM6187'
    Then I am on the 'Find management consultants' page
    And the framework is 'RM6187'

  Scenario: Go to an unrecognised famework in the admin section - logged out
    When I go to '/management-consultancy/RM9102/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM9102'
    And I click on 'RM6187'
    Then I am on '/management-consultancy/RM6187/admin/sign-in'
    And the framework is 'RM6187'

  Scenario: Go to an unrecognised famework in the admin section - logged in
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    Then I am on the 'Manage supplier data' page
    When I go to '/management-consultancy/RM9102/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM9102'
    And I click on 'RM6187'
    Then I am on the 'Manage supplier data' page
    And the framework is 'RM6187'
