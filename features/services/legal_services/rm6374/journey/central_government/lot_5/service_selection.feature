Feature: Legal services -  Central governemnt - Lot 5 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6374' framework in 'legal services'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes' for 'requirement replace an existing contract'
    And I select 'Likely' for 'requirement being awarded'
    And I select 'Yes' for 'CCS contact you'
    And I click on 'Continue'
    Then I am on the 'Please select your customer sector' page
    And I select 'Health' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Legal services requiring a deep understanding of the transport, rail, highways, maritime, ports aviation and planning industry' for 'requirements'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    Then I should see the following options for the lot:
      | Assimilated Law                               |
      | Aviation and Airports                         |
      | Competition Law                               |
      | Dispute Resolution and Litigation Law         |
      | Employment Law                                |
      | Environmental Law                             |
      | Health and Safety                             |
      | Highways Law                                  |
      | Information Law including Data Protection Law |
      | Information Technology Law                    |
      | Insurance and Reinsurance                     |
      | Intellectual Property Law                     |
      | International Law                             |
      | Maritime and Shipping                         |
      | Pensions Law                                  |
      | Planning Law                                  |
      | Public Procurement Law                        |
      | Rail Commercial Law                           |
      | Real Estate and Real Estate Finance           |
      | Regulatory Law                                |
      | Restructuring and Insolvency                  |
      | Subsidy Control Law                           |
      | Tax Law                                       |