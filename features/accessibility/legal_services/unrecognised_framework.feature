@accessibility @javascript
Feature: Legal Services - Start pages - With an unrecognised framework

  Scenario: Go to an unrecognised famework in the admin section
    When I go to '/legal-services/RM1012/admin'
    Then I am on the 'The web address contained an unrecognised framework' page
    Then the page should be axe clean
