Feature: Supply Teachers - Find individual worker - Validations

  Background: Navigate to the Do you want an agency to supply the worker? page
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'An agency who can provide my school with an individual worker'
    And I click on 'Continue'
    Then I am on the 'Do you want an agency to supply the worker?' page
  
  Scenario: Do you want an agency to supply the worker? validations
    And I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you want an agency to supply the worker |

  Scenario: Do you want the agency to manage the worker’s pay? validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I click on 'Continue'
    Then I should see the following error messages:
      | Select yes if you want to put the worker on the school’s payroll  |

  Scenario: School postcode and worker requirements validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I click on 'Continue'
    Then I should see the following error messages:
      | Enter a valid postcode                  |
      | Select how long you need the worker for |
      | Select the type of worker you need      |

  Scenario: Invalid school postcode validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'School postcode and worker requirements' page
    And I select 'Teacher: (Incl. Qualified and Unqualified Teachers, Tutors)'
    And I select 'Daily Supply'
    And I enter 'Aionios' for the 'postcode'
    And I click on 'Continue'
    Then I should see the following error messages:
      | Enter a valid postcode  |

  Scenario Outline: What date do you want the employee to start? validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
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

  Scenario Outline: What date do you want the employee to stop working? validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter '<date>' for the date
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | date        | error_message                                                                             |
      |  / / /      | Enter the contract end date, including the day, month and year                            |
      |  1/1/ /     | Enter the contract end date, including the day, month and year                            |
      | 89/45/0161  | Enter the contract end date, including the day, month and year                            |
      | a/b/c       | Enter the contract end date, including the day, month and year                            |
      | yesterday   | The date the contract ended must be after the date the worker’s current contract started  |

  Scenario Outline: What date do you want the employee to stop working? validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '<value>' for the 'salary'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | value | error_message           |
      |       | Enter the annual salary |
      | Morag | Enter a valid salary    |
      | 0     | Enter a valid salary    |
      | -89   | Enter a valid salary    |

  Scenario Outline: What is your school’s postcode? (agency worker) validations
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Do you want the agency to manage the worker’s pay?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to start?' page
    And I enter 'tomorrow' for the date
    And I click on 'Continue'
    Then I am on the 'What date do you want the employee to stop working?' page
    And I enter a date 0 years and 3 months into the future
    And I click on 'Continue'
    Then I am on the "What would the employee's annual salary be?" page
    And I enter '1234' for the 'salary'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter '<value>' for the 'postcode'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | value | error_message           |
      |       | Enter a valid postcode  |
      | Keves | Enter a valid postcode  |

  Scenario Outline: What is your school’s postcode? (nominated worker) validations
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'What is your school’s postcode?' page
    And I enter '<value>' for the 'postcode'
    And I click on 'Continue'
    Then I should see the following error messages:
      | <error_message> |

    Examples:
      | value | error_message           |
      |       | Enter a valid postcode  |
      | Keves | Enter a valid postcode  |
