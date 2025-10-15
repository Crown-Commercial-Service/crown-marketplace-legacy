Feature: Legal Panel for Government - Non central governemnt - Lot 5 - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 5 - Rail Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 5 - Rail Legal Services'
    Then I should see the following options for the lot:
      | Competition law                               |
      | Dispute Resolution and litigation law         |
      | EU law                                        |
      | Employment law                                |
      | Environmental law                             |
      | Health and Safety law                         |
      | Information law including data protection law |
      | Information technology law                    |
      | Insurance law                                 |
      | Intellectual property law                     |
      | International law                             |
      | Pensions law                                  |
      | Planning law                                  |
      | Public procurement law                        |
      | Rail Commercial Law                           |
      | Real estate law                               |
      | Regulatory law                                |
      | Restructuring/ Insolvency law                 |
      | Subsidy Control Law                           |
      | Tax law                                       |
