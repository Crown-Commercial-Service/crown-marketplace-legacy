Feature: Management Consultancy - Navigation links when signed in

  Background: I navigate to the start page
     Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'

  Scenario: Start page
    When I go to the 'management consultancy' start page for 'RM6187'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |

  Scenario Outline: Not permitted page
    And I go to the not permitted page for 'management consultancy'
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                  |
      | Back to start | Select the lot you need     |
      | Sign out      | Find management consultants |

  Scenario Outline: Cookies policy
    When I click on 'Cookie policy'
    Then I am on the 'Details about cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                  |
      | Back to start | Select the lot you need     |
      | Sign out      | Find management consultants |

  Scenario Outline: Cookies settings
    When I click on 'Cookie settings'
    Then I am on the 'Cookies on Crown Marketplace' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                  |
      | Back to start | Select the lot you need     |
      | Sign out      | Find management consultants |

  Scenario Outline: Accessibility statement
    When I click on 'Accessibility statement'
    Then I am on the 'Management Consultancy (MC) Accessibility statement' page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                  |
      | Back to start | Select the lot you need     |
      | Sign out      | Find management consultants |

  Scenario Outline: Home page
    And I should see the following navigation links:
      | Back to start |
      | Sign out      |
    And I click on the header link '<header_link>'
    Then I am on the '<page_title>' page

    Examples:
      | header_link   | page_title                  |
      | Back to start | Select the lot you need     |
      | Sign out      | Find management consultants |
