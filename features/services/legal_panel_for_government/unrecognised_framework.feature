Feature: Legal Panel for Government - Start pages - With an unrecognised framework

  Scenario Outline: Go to unrecognised famework in the buyer section - logged in
    When I go to the 'legal panel for government' start page for 'RM007'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM007'
    And I click on '<framework>'
    Then I am on the 'Find legal services for government' page
    And the framework is '<framework>'

    Examples:
      | framework |
      | RM6360    |

  Scenario Outline: Go to unrecognised famework in the buyer section - logged out
    Given I sign in and navigate to the start page for the '<framework>' framework in 'legal panel for government'
    And I go to the 'legal panel for government' start page for 'RM0172'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM0172'
    And I click on '<framework>'
    Then I am on the 'Find legal services for government' page
    And the framework is '<framework>'

    Examples:
      | framework |
      | RM6360    |

  Scenario Outline: Go to an unrecognised famework in the admin section - logged out
    When I go to '/legal-panel-for-government/RM0172/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM0172'
    And I click on '<framework>'
    Then I am on '/legal-panel-for-government/<framework>/admin/sign-in'
    And the framework is '<framework>'

    Examples:
      | framework |
      | RM6360    |

  Scenario Outline: Go to an unrecognised famework in the admin section - logged in
    Given I sign in as an admin for the '<framework>' framework in 'legal panel for government'
    Then I am on the 'Admin dashboard' page
    When I go to '/legal-panel-for-government/RM0172/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    And the unrecognised framework is 'RM0172'
    And I click on '<framework>'
    Then I am on the 'Admin dashboard' page
    And the framework is '<framework>'

    Examples:
      | framework |
      | RM6360    |
