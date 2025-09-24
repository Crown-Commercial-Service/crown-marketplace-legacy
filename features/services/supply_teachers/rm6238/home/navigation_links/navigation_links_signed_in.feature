Feature: Supply Teachers - Navigation links when signed in

  Background: I navigate to the start page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'

  Scenario: Start page
    When I go to the 'supply teachers' start page for 'RM6238'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |

  Scenario Outline: Not permitted page
    And I go to the not permitted page for 'supply teachers'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find supply teachers and agency workers' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find supply teachers and agency workers' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find supply teachers and agency workers' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find supply teachers and agency workers' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |

  Scenario Outline: Home page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the 'Find supply teachers and agency workers' page

    Examples:
      | header_link   |
      | Back to start |
      | Sign out      |
