Feature: Supply Teachers - Temp to perm - Validations

  Background: Navigate to the Find out how much you’ll be charged page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
  
  Scenario Outline: Contract start date validation
    Given I enter '<date>' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                     |
      |  / / /      | Enter a real date                                                 |
      | 1/1/ /      | Enter the contract start date, including the day, month and year  |
      | 89/45/0161  | Enter a real date                                                 |
      | a/b/c       | Enter a real date                                                 |

  Scenario Outline: Days per week validation
    Given I enter 'today' for the 'contract start' date
    And I enter '<days_per_week>' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | days_per_week | error_message                                               |
      |               | Enter the number of days worked per week                    |
      | -1            | The number of days worked per week must be between 0 and 5  |
      | 0             | The number of days worked per week must be between 0 and 5  |
      | 6             | The number of days worked per week must be between 0 and 5  |
      | so nah        | The number of days worked per week must be a number         |

  Scenario Outline: Days rate validation
    Given I enter 'today' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '<daily_fee>' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | daily_fee | error_message                                                                                                 |
      |           | Enter the number of pounds charged per day                                                                    |
      | -1        | The number of pounds charged per day must be more than 0                                                      |
      | so fern   | The number of pounds charged per day must be a number                                                         |
      | .50       | The number of pounds charged per day must be in the format of a currency with no more than two decimal places |
      | 20.543    | The number of pounds charged per day must be in the format of a currency with no more than two decimal places |

  Scenario Outline: Hire date date validation
    Given I enter 'today' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter '<date>' for the 'hire' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                                                     |
      |  / / /      | Enter a real date                                                                                                 |
      | 1/1/ /      | Enter the date you want to take the worker on permanently, including the day, month and year                      |
      | 29/02/2022  | Enter a real date                                                                                                 |
      | a/b/c       | Enter a real date                                                                                                 |
      | yesterday   | The date you want to take the worker on permanently must be after the date the worker’s current contract started  |

  Scenario Outline: Holiday 1 start date validation
    Given I enter 'yesterday' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    Given I enter '<date>' for the 'holiday 1 start' date
    And I enter a date 0 years and 3 months into the future for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                       |
      |  / / /      | Enter the date the first school holiday started, including the day, month and year  |
      | 1/1/ /      | Enter the date the first school holiday started, including the day, month and year  |
      | 29/02/2022  | Enter a real date                                                                   |
      | a/b/c       | Enter a real date                                                                   |

  Scenario Outline: Holiday 1 end date validation
    Given I enter 'yesterday' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    Given I enter 'today' for the 'holiday 1 start' date
    Given I enter '<date>' for the 'holiday 1 end' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                     |
      |  / / /      | Enter the date the first school holiday ended, including the day, month and year  |
      | 1/1/ /      | Enter the date the first school holiday ended, including the day, month and year  |
      | 29/02/2022  | Enter a real date                                                                 |
      | a/b/c       | Enter a real date                                                                 |
      | yesterday   | The end date of the first school holiday must be after the start date             |

  Scenario Outline: Holiday 2 start date validation
    Given I enter 'yesterday' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    Given I enter '<date>' for the 'holiday 2 start' date
    And I enter a date 0 years and 3 months into the future for the 'holiday 2 end' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                       |
      |  / / /      | Enter the date the second school holiday started, including the day, month and year |
      | 1/1/ /      | Enter the date the second school holiday started, including the day, month and year |
      | 31/04/2022  | Enter a real date                                                                   |
      | a/b/c       | Enter a real date                                                                   |

  Scenario Outline: Holiday 2 end date validation
    Given I enter 'yesterday' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    Given I enter 'today' for the 'holiday 2 start' date
    Given I enter '<date>' for the 'holiday 2 end' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                     |
      |  / / /      | Enter the date the second school holiday ended, including the day, month and year |
      | 1/1/ /      | Enter the date the second school holiday ended, including the day, month and year |
      | 31/04/2022  | Enter a real date                                                                 |
      | a/b/c       | Enter a real date                                                                 |
      | yesterday   | The end date of the second school holiday must be after the start date            |

  Scenario Outline: Notice date format validation
    Given I enter 'yesterday' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    Given I enter '<date>' for the 'notice' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                                               |
      | 1/1/ /      | Enter the date you notified the agency that you wish to hire the worker, including the day, month and year  |
      | 31/13/2022  | Enter a real date                                                                                           |
      | a/b/c       | Enter a real date                                                                                           |

  Scenario Outline: Notice date reletive to other dates validation
    And I enter a date 0 years and 2 months into the future for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25' for the 'daily fee'
    And I enter a date 0 years and 5 months into the future for the 'hire' date
    And I enter a date 0 years and <months> months into the future for the 'notice' date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | months  | error_message                                                                                                                         |
      | 1       | The date you notified the agency that you wish to hire the worker must be after the date the worker’s current contract started        |
      | 6       | The date you notified the agency that you wish to hire the worker must be before the date you want to take the worker on permanently  |
