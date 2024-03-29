Feature: Supply Teachers - Navigation links when signed out

  Background: I navigate to the start page
    When I go to the 'supply teachers' start page for 'RM6238'

  Scenario: Start page
    Then I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |

  Scenario: Not permitted page
    And I go to the not permitted page for 'supply teachers'
    Then I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |

  Scenario Outline: Sign in page 
    And I click on 'Start now'
    Then I am on the 'Sign in to find supply teachers and agency workers' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                                          |
      | Back to start | Find supply teachers and agency workers             |
      | Sign in       | Sign in to find supply teachers and agency workers  |

  Scenario Outline: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                                          |
      | Back to start | Find supply teachers and agency workers             |
      | Sign in       | Sign in to find supply teachers and agency workers  |

  Scenario Outline: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                                          |
      | Back to start | Find supply teachers and agency workers             |
      | Sign in       | Sign in to find supply teachers and agency workers  |

  Scenario Outline: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Supply Teachers (ST) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
    And I should see the following authentication links:
      | Sign in |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                                          |
      | Back to start | Find supply teachers and agency workers             |
      | Sign in       | Sign in to find supply teachers and agency workers  |
