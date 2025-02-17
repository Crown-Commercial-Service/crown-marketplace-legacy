@javascript
Feature: Management Consultancy - Lot 4 - Finance - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 4 - Finance'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 4 - Finance'
  
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Asset finance                                             |
      | Financial due diligence                                   |
      | Financial performance review and viability studies        |
      | Financing public projects and negotiations                |
      | Forecasting and budgeting                                 |
      | Investment, financial advice and market services          |
      | Mergers, acquisitions and divestment                      |
      | Payment structure advice and risk                         |
      | Pensions                                                  |
      | Regulation and statutory requirements                     |
      | Risk management                                           |
      | Asset management including valuation, sales and disposals |
      | Tax including value added tax (VAT)                       |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Asset finance'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset finance                                             |
    When I check the following items:
      | Financial due diligence                                   |
      | Financing public projects and negotiations                |
      | Investment, financial advice and market services          |
      | Payment structure advice and risk                         |
      | Regulation and statutory requirements                     |
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
    Then the basket should say '13 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset finance                                             |
      | Financial due diligence                                   |
      | Financing public projects and negotiations                |
      | Investment, financial advice and market services          |
      | Payment structure advice and risk                         |
      | Regulation and statutory requirements                     |
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Asset finance                                             |
      | Financial performance review and viability studies        |
      | Forecasting and budgeting                                 |
      | Mergers, acquisitions and divestment                      |
      | Pensions                                                  |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Capital fundraising, derivatives and hedging              |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
    Then the basket should say '12 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset finance                                             |
      | Financial performance review and viability studies        |
      | Forecasting and budgeting                                 |
      | Mergers, acquisitions and divestment                      |
      | Pensions                                                  |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Capital fundraising, derivatives and hedging              |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
    When I deselect the following items:
      | Mergers, acquisitions and divestment                      |
    Then the basket should say '11 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset finance                                             |
      | Financial performance review and viability studies        |
      | Forecasting and budgeting                                 |
      | Pensions                                                  |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Capital fundraising, derivatives and hedging              |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
    When I remove the following items from the basket:
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset finance                                             |
      | Financial performance review and viability studies        |
      | Forecasting and budgeting                                 |
      | Pensions                                                  |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Capital fundraising, derivatives and hedging              |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Economic analysis                                         |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Asset finance                                             |
      | Financial due diligence                                   |
      | Financial performance review and viability studies        |
      | Financing public projects and negotiations                |
      | Investment, financial advice and market services          |
      | Mergers, acquisitions and divestment                      |
      | Pensions                                                  |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Capital fundraising, derivatives and hedging              |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Economic analysis                                         |

    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Asset finance                                             |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Financial performance review and viability studies        |
      | Capital fundraising, derivatives and hedging              |
      | Financing public projects and negotiations                |
      | Investment, financial advice and market services          |
      | Pensions                                                  |
      | Risk management                                           |
      | Financial due diligence                                   |
      | Tax including value added tax (VAT)                       |
      | Economic analysis                                         |
      | Mergers, acquisitions and divestment                      |
