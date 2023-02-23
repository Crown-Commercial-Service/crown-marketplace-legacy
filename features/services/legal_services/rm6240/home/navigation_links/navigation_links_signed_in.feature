Feature: Legal Services - Navigation links when signed in

  Background: I navigate to the start page
     Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'

  Scenario: Start page
    When I go to the 'legal services' start page for 'RM6240'
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |

  Scenario Outline: Not permitted page
    And I go to the not permitted page for 'legal services'
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find legal services for the wider public sector' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find legal services for the wider public sector' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find legal services for the wider public sector' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Legal Services (LS) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find legal services for the wider public sector' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Home page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find legal services for the wider public sector' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |
