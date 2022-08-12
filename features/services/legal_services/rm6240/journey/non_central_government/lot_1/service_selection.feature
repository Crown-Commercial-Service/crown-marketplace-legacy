@javascript
Feature: Legal services - Non central governemnt - Lot 1 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6240' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 1 - Full service provision'
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 1 - Full service provision'

  @pipeline
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Administrative and Public Law                   |
      | Charities Law                                   |
      | Children and Vulnerable Adults                  |
      | Competition Law                                 |
      | Contracts                                       |
      | Corporate Law                                   |
      | Data Protection and Information Law             |
      | Education Law                                   |
      | Employment                                      |
      | Energy, Natural Resources and Climate Change    |
      | Food, Rural and Environmental Affairs           |
      | Franchise Law                                   |
      | Health and Safety                               |
      | Health, Healthcare and Social Care              |
      | Immigration                                     |
      | Information Technology                          |
      | Infrastructure                                  |
      | Intellectual Property                           |
      | International Trade, Investment and Regulation  |
      | Islamic Finance / Sukuk                         |
      | Licensing Law                                   |
      | Life Sciences                                   |
      | Litigation and Dispute Resolution               |
      | Media Law                                       |
      | Mental Health Law                               |
      | Non-Complex Finance and Investment              |
      | Outsourcing / Insourcing                        |
      | Partnerships                                    |
      | Pensions                                        |
      | Planning                                        |
      | Projects                                        |
      | Property, Real Estate and Construction          |
      | Public Inquests and Inquiries                   |
      | Public International Law                        |
      | Public Procurement                              |
      | Restructuring and Insolvency                    |
      | Retained EU Law and EU Law                      |
      | Tax                                             |
      | Telecommunications                              |
      | Transport Law (excluding Rail)                  |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Children and Vulnerable Adults'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults      |
    When I check the following items:
      | Charities Law                       |
      | Data Protection and Information Law |
      | Education Law                       |
      | Employment                          |
      | Health, Healthcare and Social Care  |
      | Intellectual Property               |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults      |
      | Charities Law                       |
      | Data Protection and Information Law |
      | Education Law                       |
      | Employment                          |
      | Health, Healthcare and Social Care  |
      | Intellectual Property               |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Children and Vulnerable Adults      |
      | Education Law                       |
      | Health, Healthcare and Social Care  |
      | Transport Law (excluding Rail)      |
      | Telecommunications                  |
      | Pensions                            |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults      |
      | Education Law                       |
      | Health, Healthcare and Social Care  |
      | Transport Law (excluding Rail)      |
      | Telecommunications                  |
      | Pensions                            |
    When I deselect the following items:
      | Transport Law (excluding Rail)  |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults      |
      | Education Law                       |
      | Health, Healthcare and Social Care  |
      | Telecommunications                  |
      | Pensions                            |
    When I remove the following items from the basket:
      | Education Law       |
      | Telecommunications  |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Children and Vulnerable Adults      |
      | Health, Healthcare and Social Care  |
      | Pensions                            |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from jurisdiction and change selection
    When I check the following items:
      | Infrastructure                                  |
      | Intellectual Property                           |
      | International Trade, Investment and Regulation  |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | Infrastructure                                  |
      | Intellectual Property                           |
      | International Trade, Investment and Regulation  |
