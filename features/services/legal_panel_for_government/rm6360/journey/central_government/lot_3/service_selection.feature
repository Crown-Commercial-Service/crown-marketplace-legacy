@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 3 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 3 - Finance and High Risk/Innovation'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 3 - Finance and High Risk/Innovation'

  Scenario: The correct options are available
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

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Credit Insurance and Related Products'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Credit Insurance and Related Products |
    When I check the following items:
      | Debt Capital Markets                  |
      | Investment and Asset Management       |
      | Merger and Acquisition Activity       |
      | Restructuring/Insolvency              |
      | Sovereign Debt Restructuring          |
      | United State Securities & Regulatory  |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Credit Insurance and Related Products |
      | Debt Capital Markets                  |
      | Investment and Asset Management       |
      | Merger and Acquisition Activity       |
      | Restructuring/Insolvency              |
      | Sovereign Debt Restructuring          |
      | United State Securities & Regulatory  |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Corporate Finance                     |
      | Credit Insurance and Related Products |
      | Energy and Natural Resources          |
      | Equity Capital Markets                |
      | Merger and Acquisition Activity       |
      | Project and Asset Finance             |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Corporate Finance                     |
      | Credit Insurance and Related Products |
      | Energy and Natural Resources          |
      | Equity Capital Markets                |
      | Merger and Acquisition Activity       |
      | Project and Asset Finance             |
    When I deselect the following items:
      | Project and Asset Finance             |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Corporate Finance                     |
      | Credit Insurance and Related Products |
      | Energy and Natural Resources          |
      | Equity Capital Markets                |
      | Merger and Acquisition Activity       |
    When I remove the following items from the basket:
      | Equity Capital Markets                |
      | Merger and Acquisition Activity       |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Corporate Finance                     |
      | Credit Insurance and Related Products |
      | Energy and Natural Resources          |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  # TODO: Add this scenario
  # Scenario: Go back from jurisdiction and change selection
  #   When I check the following items:
  #     | Infrastructure                                  |
  #     | Intellectual Property Law                       |
  #     | International Trade, Investment and Regulation  |
  #   And I click on 'Continue'
  #   Then I am on the 'Select the jurisdiction you need' page
  #   And I click on the 'Back' back link
  #   Then I am on the 'Select the legal services you need' page
  #   And the following items should appear in the basket:
  #     | Infrastructure                                  |
  #     | Intellectual Property Law                       |
  #     | International Trade, Investment and Regulation  |
