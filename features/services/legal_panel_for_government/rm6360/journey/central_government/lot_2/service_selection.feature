Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Service selection

  Background: Navigate to start page and select the lot
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
    And I select 'Lot 2 - Major Projects and Complex Advice'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 2 - Major Projects and Complex Advice'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Assimilated Law                                             |
      | Aviation and Airports                                       |
      | Charities                                                   |
      | Children and Vulnerable Adults                              |
      | Commercial Litigation and Dispute Resolution                |
      | Competition Law                                             |
      | Construction Law                                            |
      | Contracts                                                   |
      | Corporate Finance                                           |
      | Corporate Law                                               |
      | Credit Insurance and Related Products                       |
      | Debt Capital Markets                                        |
      | Education Law                                               |
      | Employment Law                                              |
      | Energy and Natural Resources                                |
      | Environmental Law                                           |
      | Equity Capital Markets                                      |
      | Finance and Investment                                      |
      | Financial Institutions Rescue, Restructuring and Insolvency |
      | Financial Services, Market and Competition Regulation       |
      | Fintech Crypto Assets                                       |
      | Food, Rural and Environmental Affairs                       |
      | Franchise Law                                               |
      | Grants                                                      |
      | Health and Safety                                           |
      | Health, Healthcare and Social Care                          |
      | Housing Law                                                 |
      | Immigration                                                 |
      | Information Law including Data Protection Law               |
      | Information Technology Law                                  |
      | Insurance and Reinsurance                                   |
      | Intellectual Property Law                                   |
      | International Development/Aid Funding                       |
      | International Finance Organisations                         |
      | International Trade                                         |
      | Investment and Asset Management                             |
      | Investment and Commercial Banking                           |
      | Islamic Finance / Sukuk                                     |
      | Life Sciences                                               |
      | Maritime and Shipping                                       |
      | Media Law                                                   |
      | Merger & Acquisition Activity                               |
      | Outsourcing                                                 |
      | Partnership Law                                             |
      | Pensions Law                                                |
      | Planning Law                                                |
      | Private Law Litigation and Dispute resolution               |
      | Project and Asset Finance                                   |
      | Projects/PFI/PPP                                            |
      | Public Inquiries - Support to Participants and Inquests     |
      | Public International Law                                    |
      | Public Law                                                  |
      | Public Law Litigation and Dispute Resolution                |
      | Public Procurement Law                                      |
      | Real Estate and Real Estate Finance                         |
      | Restructuring/Insolvency                                    |
      | Supporting Public Inquiries                                 |
      | Sustainable Finance / Green Finance                         |
      | Tax Law                                                     |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No specialisms selected'
    And the remove all link should not be visible
    When I check 'Credit Insurance and Related Products'
    Then the basket should say '1 specialism selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Credit Insurance and Related Products |
    When I check the following items:
      | Food, Rural and Environmental Affairs |
      | Health, Healthcare and Social Care    |
      | Insurance and Reinsurance             |
      | Outsourcing                           |
      | Planning Law                          |
      | Supporting Public Inquiries           |
    Then the basket should say '7 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Credit Insurance and Related Products |
      | Food, Rural and Environmental Affairs |
      | Health, Healthcare and Social Care    |
      | Insurance and Reinsurance             |
      | Outsourcing                           |
      | Planning Law                          |
      | Supporting Public Inquiries           |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Competition Law                   |
      | Fintech Crypto Assets             |
      | Investment and Commercial Banking |
      | Life Sciences                     |
      | Merger & Acquisition Activity     |
      | Restructuring/Insolvency          |
    Then the basket should say '6 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Competition Law                   |
      | Fintech Crypto Assets             |
      | Investment and Commercial Banking |
      | Life Sciences                     |
      | Merger & Acquisition Activity     |
      | Restructuring/Insolvency          |
    When I deselect the following items:
      | Restructuring/Insolvency |
    Then the basket should say '5 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Competition Law                   |
      | Fintech Crypto Assets             |
      | Investment and Commercial Banking |
      | Life Sciences                     |
      | Merger & Acquisition Activity     |
    When I remove the following items from the basket:
      | Life Sciences                 |
      | Merger & Acquisition Activity |
    Then the basket should say '3 specialisms selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Competition Law                   |
      | Fintech Crypto Assets             |
      | Investment and Commercial Banking |
    When I click on 'Remove all'
    Then the basket should say 'No specialisms selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | Competition Law  |
      | Construction Law |
      | Contracts        |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal specialisms you need' page
    And the following items should appear in the basket:
      | Competition Law  |
      | Construction Law |
      | Contracts        |
