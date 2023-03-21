Feature: Supply Teachers - FTA to perm - Validations

  Background: Navigate to the FTA to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To work out what fixed-term worker transfer fee I could be charged'
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract start?' page

  Scenario Outline: What date did the workers fixed term contract start? validations
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                     |
      |  / / /      | Enter the contract start date, including the day, month and year  |
      |  1/1/ /     | Enter the contract start date, including the day, month and year  |
      | 89/45/0161  | Enter the contract start date, including the day, month and year  |
      | a/b/c       | Enter the contract start date, including the day, month and year  |

  Scenario Outline: What date did the workers fixed term contract end? validations
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                             |
      |  / / /      | Enter the contract end date, including the day, month and year                            |
      |  1/1/ /     | Enter the contract end date, including the day, month and year                            |
      | 89/45/8901  | Enter the contract end date, including the day, month and year                            |
      | a/b/c       | Enter the contract end date, including the day, month and year                            |
      | yesterday   | The date the contract ended must be after the date the worker’s current contract started  |

  Scenario Outline: What date did the workers fixed term contract end? validations
    And I enter 'yesterday' for the date
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                                   |
      |  / / /      | Enter the date, including the day, month and year                                               |
      |  1/1/ /     | Enter the date, including the day, month and year                                               |
      | 12/34/5678  | Enter the date, including the day, month and year                                               |
      | a/b/c       | Enter the date, including the day, month and year                                               |
      | today       | The date that you wish to hire the worker must be after the date the fixed term contract ended  |

  Scenario Outline: What fixed term fee did you pay the worker? validations
    And I enter 'yesterday' for the date
    And I click on 'Continue'
    Then I am on the 'What date did the workers fixed term contract end?' page
    And I enter 'today' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want their fully permanent employment to start?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the "If you wait and do not employ until" page
    And I click on "I don't want to wait that long - continue to calculate fee"
    Then I am on the 'What fixed term fee did you pay the worker?' page
    And I enter '<fixed_term_fee>' for the 'fixed term fee'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | fixed_term_fee  | error_message                             |
      |                 | Enter the fixed term fee                  |
      | -1              | The fixed term fee must be more than 0    |
      | Lanz            | The fixed term fee must must be a number  |
