Feature: Legal services - Non central governemnt - Lot 2 - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - General service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - General service provision'
    Then I should see the following options for the lot:
      | Child Law                       |
      | Court of Protection             |
      | Debt Recovery                   |
      | Education Law                   |
      | Employment                      |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Litigation / Dispute Resolution |
      | Mental Health Law               |
      | Pensions                        |
      | Planning and Environment        |
      | Primary Care                    |
      | Property and Construction       |
      | Social Housing                  |
