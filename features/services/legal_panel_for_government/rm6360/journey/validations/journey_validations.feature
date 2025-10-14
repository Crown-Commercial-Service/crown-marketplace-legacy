Feature: Legal Panel for Government - Jounrey validations

  Background: Navigate to start page
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'

  Scenario: Do you work for central government validation
    Given I am on the 'Do you work for central government or an arms length body?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you work for central government or an arms length body |

  Scenario: Information about your requirements blank validations
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Enter the intended start date, including the month and year     |
      | Enter the intended end date, including the month and year       |
      | The estimated total value must be a whole number greater than 0 |
      | You must select an option                                       |

  Scenario Outline: Information about your requirements start date validations
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '<date>' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date    | error_message                                               |
      | / /     | Enter the intended start date, including the month and year |
      | 1/ /    | Enter the intended start date, including the month and year |
      | 34/5678 | Enter a real date for the intended start date               |
      | b/c     | Enter a real date for the intended start date               |

  Scenario Outline: Information about your requirements end date validations
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '<date>' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date    | error_message                                               |
      | / /     | Enter the intended end date, including the month and year   |
      | 1/ /    | Enter the intended end date, including the month and year   |
      | 34/5678 | Enter a real date for the intended end date                 |
      | b/c     | Enter a real date for the intended end date                 |
      | 10/2023 | The intended end date must be after the intended start date |

  Scenario Outline: Information about your requirements requirement estimated total value validations
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '<value>' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | value         | error_message                                                              |
      |               | The estimated total value must be a whole number greater than 0            |
      | 0             | The estimated total value must be a whole number greater than 0            |
      | 1000000000000 | The estimated total value must be less than 1,000,000,000,000 (1 trillion) |
      | 67.4          | The estimated total value must be a whole number greater than 0            |
      | Big int       | The estimated total value must be a whole number greater than 0            |

  Scenario: Select the lot you need validations - central government yes
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the lot you need |

  Scenario: Select the legal specialisms you need - not Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal specialism |

  Scenario: Is your requirement for a location outside of the countries listed below?
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select if your requirement is for a country outside the listed locations |

  Scenario: Select the countries for your requirement
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select the countries for your requirement |

  Scenario: Select the legal specialisms you need - Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | Select at least one legal specialism |

  Scenario: Select suppliers for comparison - not Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And I check 'Children and Vulnerable Adults'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - one supplier - not Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And I check 'Children and Vulnerable Adults'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I check 'CORMIER INC'
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And I check 'Assimilated Law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |

  Scenario: Select suppliers for comparison - one supplier - Lot 4
    Given I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Given I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And I select 'No'
    When I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And I check 'Assimilated Law'
    When I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on 'Compare the supplier rates'
    Then I am on the 'Select suppliers for comparison' page
    When I check 'CROOKS AND SONS'
    When I click on 'Continue'
    Then I should see the following error messages:
      | You must select at least two suppliers for comparison |
