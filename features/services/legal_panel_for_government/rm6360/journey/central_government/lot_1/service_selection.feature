Feature: Legal Panel for Government - Non central governemnt - Lot 1 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Core Legal Services'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Core Legal Services'

  @javascript
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Assimilated Law                                         |
      | Aviation and Airports                                   |
      | Charities                                               |
      | Children and Vulnerable Adults                          |
      | Commercial Litigation and Dispute Resolution            |
      | Competition Law                                         |
      | Construction Law                                        |
      | Contracts                                               |
      | Corporate Law                                           |
      | Education Law                                           |
      | Employment Law                                          |
      | Energy and Natural Resources                            |
      | Environmental Law                                       |
      | Finance and Investment                                  |
      | Financial Services, Market and Competition Regulation   |
      | Fintech Crypto Assets                                   |
      | Food, Rural and Environmental Affairs                   |
      | Franchise Law                                           |
      | Grants                                                  |
      | Health and Safety                                       |
      | Health, Healthcare and Social Care                      |
      | Housing Law                                             |
      | Immigration                                             |
      | Information Law including Data Protection Law           |
      | Information Technology Law                              |
      | Insurance and Reinsurance                               |
      | Intellectual Property Law                               |
      | International Trade                                     |
      | Life Sciences                                           |
      | Maritime and Shipping                                   |
      | Media Law                                               |
      | Merger & Acquisition Activity                           |
      | Outsourcing                                             |
      | Partnership Law                                         |
      | Pensions Law                                            |
      | Planning Law                                            |
      | Private Law Litigation and Dispute Resolution           |
      | Projects/PFI/PPP                                        |
      | Public Inquiries - Support to Participants and Inquests |
      | Public International Law                                |
      | Public Law                                              |
      | Public Law Litigation and dispute resolution            |
      | Public Procurement Law                                  |
      | Real Estate and Real Estate Finance                     |
      | Restructuring/Insolvency                                |
      | Supporting Public Inquiries                             |
      | Sustainable Finance/ Green Finance                      |
      | Tax Law                                                 |

  @javascript
  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Children and Vulnerable Adults'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults |
    When I check the following items:
      | Charities                          |
      | Education Law                      |
      | Fintech Crypto Assets              |
      | Employment Law                     |
      | Health, Healthcare and Social Care |
      | Intellectual Property Law          |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults     |
      | Charities                          |
      | Education Law                      |
      | Fintech Crypto Assets              |
      | Employment Law                     |
      | Health, Healthcare and Social Care |
      | Intellectual Property Law          |

  @javascript
  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Children and Vulnerable Adults     |
      | Education Law                      |
      | Health, Healthcare and Social Care |
      | Tax Law                            |
      | Planning Law                       |
      | Pensions Law                       |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults     |
      | Education Law                      |
      | Health, Healthcare and Social Care |
      | Tax Law                            |
      | Pensions Law                       |
      | Planning Law                       |
    When I deselect the following items:
      | Tax Law |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults     |
      | Education Law                      |
      | Health, Healthcare and Social Care |
      | Pensions Law                       |
      | Planning Law                       |
    When I remove the following items from the basket:
      | Education Law |
      | Planning Law  |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults     |
      | Health, Healthcare and Social Care |
      | Pensions Law                       |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  @javascript
  Scenario: Go back from suppliers and change selection
    When I check the following items:
      | Assimilated Law       |
      | Aviation and Airports |
      | Charities             |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Assimilated Law       |
      | Aviation and Airports |
      | Charities             |
