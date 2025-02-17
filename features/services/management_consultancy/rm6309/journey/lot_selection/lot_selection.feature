Feature: Management Consultancy - Lot selection

  Scenario: Back from select lot page
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Then I am on the 'Select the lot you need' page
    Given I click on the 'Back' back link
    Then I am on the 'Find management consultants' page
    And I am on '/management-consultancy/RM6309'
