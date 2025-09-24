Feature: Legal Panel for Government - Navigation links when signed out

  Background: I navigate to the start page
    When I go to the 'legal panel for government' start page for 'RM6360'

  Scenario: Start page
    Then I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |

  Scenario: Not permitted page
    And I go to the not permitted page for 'legal panel for government'
    Then I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |

  Scenario Outline: Sign in page
    And I click on 'Start now'
    Then I am on the 'Sign in to your legal panel for government account' page
    And I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link       | page_title                                         |
      | Back to start     | Find legal services for government                 |
      | Create an account | Create a CCS account                               |
      | Sign in           | Sign in to your legal panel for government account |

  Scenario Outline: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link       | page_title                                         |
      | Back to start     | Find legal services for government                 |
      | Create an account | Create a CCS account                               |
      | Sign in           | Sign in to your legal panel for government account |

  Scenario Outline: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link       | page_title                                         |
      | Back to start     | Find legal services for government                 |
      | Create an account | Create a CCS account                               |
      | Sign in           | Sign in to your legal panel for government account |

  Scenario Outline: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Panel for Government (LPG) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start     |
      | Create an account |
      | Sign in           |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link       | page_title                                         |
      | Back to start     | Find legal services for government                 |
      | Create an account | Create a CCS account                               |
      | Sign in           | Sign in to your legal panel for government account |
