@pipeline
Feature: Supply Teachers - Master vendors

  Scenario: Master vendor results
    Given I sign in and navigate to the start page for the 'RM3826' framework in 'supply teachers'
    And I select "An agency to manage all my school's needs; a 'managed service provider - Master Vendor"
    And I click on 'Continue'
    Then I am on the 'Master vendor managed service providers' page
    And there are 4 managed service provider agencies
    And the managed service provider agencies are:
      | BOTSFORD AND SONS     |
      | KUVALIS-HARRIS        |
      | BODE, RUNTE AND RATH  |
      | EBERT AND SONS        |
    And the contact details for the managed service provider 'BODE, RUNTE AND RATH' are:
      | Amb. Silas Yundt                        |
      | 522-654-7009 x42847                     |
      | runte_rath_bode_and@anderson-bailey.com |
    And the master vendor agency 'BODE, RUNTE AND RATH' has the following rates:
      | Administrative and clerical staff, IT staff, finance staff and cleaners | 19.7% | 18.7% | 17.7% |
      | Headteacher and senior leadership positions                             | 14.3% | 13.5% | 12.8% |
      | Employed directly                                                       | 9.8%  | 9.8%  | 9.8%  |
    And I click on 'Back'
    Then I am on the 'What is your school looking for?' page