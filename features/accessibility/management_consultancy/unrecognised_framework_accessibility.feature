@accessibility @javascript
Feature: Management Consultancy - Unrecognised framework - accessibility

  Scenario: Go to an unrecognised famework in the admin section
    When I go to '/management-consultancy/RM9102/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    Then the page should be axe clean excluding ".ccs-contact-us"
