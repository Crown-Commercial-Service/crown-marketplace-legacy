@javascript @pipeline
Feature: Legal services - Non central governemnt - Lot 2 - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM3788' framework in 'legal services'
    Then I am on the 'Do you work for central government?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 2 - Full-service firms'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Full-service firms'

  Scenario Outline: The correct options are available for all regions
    And I select '<region>'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    Then I should see the following options for the lot:
      | Administrative and public law                             |
      | Banking and Finance                                       |
      | Charities law                                             |
      | Child law                                                 |
      | Competition law                                           |
      | Contracts                                                 |
      | Corporate and M&A                                         |
      | Data protection and information law                       |
      | EU                                                        |
      | Education law                                             |
      | Employment                                                |
      | Energy and natural resources                              |
      | Food, rural and environmental affairs                     |
      | Franchise law                                             |
      | Health & safety law                                       |
      | Health and healthcare                                     |
      | Information technology                                    |
      | Infrastructure                                            |
      | Intellectual property                                     |
      | Licensing                                                 |
      | Life sciences                                             |
      | Litigation and dispute resolution                         |
      | Outsourcing / insourcing                                  |
      | Partnerships                                              |
      | Pensions                                                  |
      | Planning                                                  |
      | Projects                                                  |
      | Property, real estate & construction                      |
      | Public international law                                  |
      | Public procurement                                        |
      | Restructuring and insolvency                              |
      | Tax                                                       |
      | Telecommunications                                        |
      | The law of international trade, investment and regulation |
      | Transport law (excluding rail)                            |

    Examples:
      | region            |
      | England and Wales |
      | Scotland          |
      | Northern Ireland  |

  Scenario: Service selection appears in basked
    And I select 'England and Wales'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Child law'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                           |
    When I check the following items:
      | Charities law                       |
      | Data protection and information law |
      | Education law                       |
      | Employment                          |
      | Health and healthcare               |
      | Intellectual property               |
    Then the basket should say '7 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                           |
      | Charities law                       |
      | Data protection and information law |
      | Education law                       |
      | Employment                          |
      | Health and healthcare               |
      | Intellectual property               |

  Scenario: Changing the selection will change the basket
    And I select 'Scotland'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    When I check the following items:
      | Child law                       |
      | Education law                   |
      | Health and healthcare           |
      | Transport law (excluding rail)  |
      | Telecommunications              |
      | Pensions                        |
    Then the basket should say '6 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                       |
      | Education law                   |
      | Health and healthcare           |
      | Transport law (excluding rail)  |
      | Telecommunications              |
      | Pensions                        |
    When I deselect the following items:
      | Transport law (excluding rail) |
    Then the basket should say '5 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law                       |
      | Education law                   |
      | Health and healthcare           |
      | Telecommunications              |
      | Pensions                        |
    When I remove the following items from the basket:
      | Education law       |
      | Telecommunications  |
    Then the basket should say '3 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Child law             |
      | Health and healthcare |
      | Pensions              |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    And I select 'Northern Ireland'
    And I click on 'Continue'
    And I am on the 'Select the legal services you need' page
    And the sub title is 'Lot 2 - Full-service firms'
    When I check the following items:
      | Child law                       |
      | Education law                   |
      | EU                              |
      | Transport law (excluding rail)  |
      | Telecommunications              |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the legal services you need' page
    And the following items should appear in the basket:
      | EU                              |
      | Child law                       |
      | Education law                   |
      | Telecommunications              |
      | Transport law (excluding rail)  |
