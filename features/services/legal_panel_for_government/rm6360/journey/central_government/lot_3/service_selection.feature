Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Service selection

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
    And I select 'Lot 3 - Finance and High Risk/Innovation'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 3 - Finance and High Risk/Innovation'
    Then I should see the following options for the lot:
      | Corporate Finance                                           |
      | Corporate Law                                               |
      | Credit Insurance and Related Products                       |
      | Debt Capital Markets                                        |
      | Energy and Natural Resources                                |
      | Equity Capital Markets                                      |
      | Financial Institutions Rescue, Restructuring and Insolvency |
      | Financial Services, Market and Competition Regulation       |
      | Fintech Crypto Assets                                       |
      | Insurance and Reinsurance                                   |
      | International Development/Aid Funding                       |
      | International Finance Organisations                         |
      | Investment and Asset Management                             |
      | Investment and Commercial Banking                           |
      | Islamic Finance / Sukuk                                     |
      | Litigation and Dispute Resolution                           |
      | Merger and Acquisition Activity                             |
      | Project and Asset Finance                                   |
      | Projects and transactions                                   |
      | Restructuring/Insolvency                                    |
      | Sovereign Debt Restructuring                                |
      | Sustainable Finance/ Green Finance                          |
      | United State Securities & Regulatory                        |
