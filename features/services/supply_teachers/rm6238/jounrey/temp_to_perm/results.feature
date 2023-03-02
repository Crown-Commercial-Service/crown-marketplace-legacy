Feature: Supply Teachers - Temp to perm - Results

  Background: Navigate to the temp to perm section
    Given I sign in and navigate to the start page for the 'RM6238' framework in 'supply teachers'
    And I select 'To calculate the fee my school will be charged if I make an agency worker permanent'
    And I click on 'Continue'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    Given I enter '3/4/2021' for the 'contract start' date
    And I enter '5' for the 'days per week'
    And I enter '25.50' for the 'daily fee'

  Scenario: Hiring after 12 weeks - no notice
    Given I enter '12/12/2021' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on permanently after 12 working weeks,  |
      | but it’s not clear if you’re providing the agency with 4 working weeks’ notice.                         |
    And I click on 'Back'
    Then I am on the 'Find out how much you’ll be charged if you make an agency worker permanent' page
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on permanently after 12 working weeks,  |
      | but it’s not clear if you’re providing the agency with 4 working weeks’ notice.                         |

  Scenario: Hiring after 12 weeks - not enough notice
    Given I enter '12/12/2021' for the 'hire' date
    Given I enter '08/12/2021' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on after 12 working weeks,          |
      | but you’re not giving 4 working weeks’ notice, so you can be charged a fee.                         |
      | Notice period given: 3 working days between Wednesday 08 December 2021 and Sunday 12 December 2021  |

  Scenario: Hiring after 12 weeks - enough notice
    Given I enter '12/12/2021' for the 'hire' date
    Given I enter '11/11/2021' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on after 12 working weeks |
      | and giving 4 working weeks’ notice, so you can’t be charged a fee under this deal.        |

  Scenario: Hiring between 9 and 12 weeks - no notice
    Given I enter '19/06/2021' for the 'hire' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on permanently within their first 12 working weeks, |
      | but it’s not clear if you’re providing the agency with 4 working weeks’ notice.                                     |
      | Working days between contract start (Saturday 03 April 2021) and hire date (Saturday 19 June 2021): 52              |
      | Difference: 8 working days                                                                                          |

  Scenario: Hiring between 9 and 12 weeks - not enough notice
    Given I enter '19/06/2021' for the 'hire' date
    Given I enter '10/06/2021' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on within their first 12 working weeks  |
      | and are not giving 4 working weeks’ notice, so you can be charged a fee.                                |
      | Notice period given: 7 working days between Thursday 10 June 2021 and Saturday 19 June 2021             |

  Scenario: Hiring between 9 and 12 weeks - enough notice
    Given I enter '19/06/2021' for the 'hire' date
    Given I enter '10/05/2021' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on within the first 12 working weeks  |
      | of their contract, so you can be charged a fee even though you’ve given 4 working weeks’ notice.      |

  Scenario Outline: Hiring before 9 - notice period does not change result
    Given I enter '29/05/2021' for the 'hire' date
    Given I enter '<date>' for the 'notice' date
    And I click on 'Continue'
    Then I am on the 'Temp-to-perm fee' page
    And the resultant information includes:
      | Based on the information you provided, you’re taking the worker on permanently within their first 12 working weeks, |
      | so you can be charged a fee.                                                                                        |
      | Working days between contract start (Saturday 03 April 2021) and hire date (Saturday 29 May 2021): 38               |

    Examples:
      | date        |
      | / / /       |
      | 25/05/2021  |
      | 20/04/2021  |
