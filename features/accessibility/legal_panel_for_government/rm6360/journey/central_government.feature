@accessibility @javascript
Feature: Legal Panel for Government - Central government - Accessibility

  Background: Login and then navigate to the select the lot you need page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page

  Scenario: Do you work for central government?
    Then the page should be axe clean excluding ".ccs-contact-us"
    
  Scenario: Select the lot you need
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    Then the page should be axe clean excluding ".ccs-contact-us"

  Scenario Outline: Select the legal services you need
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Then the page should be axe clean excluding ".ccs-contact-us"

    Examples:
      | lot                                       |
      | Lot 1 - Core Legal Services               |
      | Lot 2 - Major Projects and Complex Advice |
      | Lot 3 - Finance and High Risk/Innovation  |
      | Lot 5 - Rail Legal Services               |

  Scenario Outline: Is your requirement for a location outside of the countries listed below?
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    Then the page should be axe clean excluding ".ccs-contact-us"

    Examples:
      | lot                                         |
      | Lot 4a - Trade and Investment Negotiations  |
      | Lot 4b - International Trade Disputes       |
      | Lot 4c - International Investment Disputes  |

  Scenario Outline: Select the countries for your requirement
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'Yes'
    And I click on 'Continue'
    And I am on the 'Select the countries for your requirement' page
    And the sub title is '<lot>'
    Then the page should be axe clean excluding ".ccs-contact-us"

    Examples:
      | lot                                         |
      | Lot 4a - Trade and Investment Negotiations  |
      | Lot 4b - International Trade Disputes       |
      | Lot 4c - International Investment Disputes  |

  Scenario Outline: Select the legal services you need - Lot 4
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select '<lot>'
    And I click on 'Continue'
    And I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is '<lot>'
    And I select 'No'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is '<lot>'
    Then the page should be axe clean excluding ".ccs-contact-us"

    Examples:
      | lot                                         |
      | Lot 4a - Trade and Investment Negotiations  |
      | Lot 4b - International Trade Disputes       |
      | Lot 4c - International Investment Disputes  |
