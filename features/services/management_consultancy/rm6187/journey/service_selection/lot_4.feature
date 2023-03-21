@javascript
Feature: Management Consultancy - Lot 4 - Finance - Service selection

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6187' framework in 'management consultancy'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    Given I select 'Lot 4 - Finance'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF3 lot 4 - Finance'
  
  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Actuarial services                                        |
      | Financial due diligence                                   |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
      | Financial performance review and viability studies        |
      | Financing public infrastructure projects and negotiations |
      | Forecasting and budgeting                                 |
      | Foreign exchange                                          |
      | Investment, financial advice and market services          |
      | Mergers, acquisitions and divestment                      |
      | Payment structure advice and risk                         |
      | Asset management including valuation, sales and disposals |
      | Pensions services                                         |
      | Policy impact assessments                                 |
      | Regulation and statutory requirements and/or reporting    |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Corporate restructuring and flotation                     |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |

  Scenario: Service selection appears in basked
    Then the basket should say 'No services selected'
    And the remove all link should not be visible
    When I check 'Actuarial services'
    Then the basket should say '1 service selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Actuarial services                                      |
    When I check the following items:
      | Business analysis                                       |
      | Cash management                                         |
      | Debt restructuring, management and insolvency           |
      | Economic analysis                                       |
      | Financial accounting and/or reporting                   |
      | Financial due diligence                                 |
      | Financial performance review and viability studies      |
      | Foreign exchange                                        |
      | Payment structure advice and risk                       |
      | Regulation and statutory requirements and/or reporting  |
      | Risk management                                         |
      | Tax including value added tax (VAT)                     |
    Then the basket should say '13 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Actuarial services                                      |
      | Business analysis                                       |
      | Cash management                                         |
      | Debt restructuring, management and insolvency           |
      | Economic analysis                                       |
      | Financial accounting and/or reporting                   |
      | Financial due diligence                                 |
      | Financial performance review and viability studies      |
      | Foreign exchange                                        |
      | Payment structure advice and risk                       |
      | Regulation and statutory requirements and/or reporting  |
      | Risk management                                         |
      | Tax including value added tax (VAT)                     |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
      | Mergers, acquisitions and divestment                      |
      | Pensions services                                         |
      | Regulation and statutory requirements and/or reporting    |
      | Tax including value added tax (VAT)                       |
    Then the basket should say '12 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
      | Mergers, acquisitions and divestment                      |
      | Pensions services                                         |
      | Regulation and statutory requirements and/or reporting    |
      | Tax including value added tax (VAT)                       |
    When I deselect the following items:
      | Regulation and statutory requirements and/or reporting    |
    Then the basket should say '11 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
      | Mergers, acquisitions and divestment                      |
      | Pensions services                                         |
      | Tax including value added tax (VAT)                       |
    When I remove the following items from the basket:
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
    Then the basket should say '9 services selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Mergers, acquisitions and divestment                      |
      | Pensions services                                         |
      | Tax including value added tax (VAT)                       |
    When I click on 'Remove all'
    Then the basket should say 'No services selected'

  Scenario: Go back from supplier results and change selection
    When I check the following items:
      | Business analysis                                         |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
      | Financial performance review and viability studies        |
      | Financing public infrastructure projects and negotiations |
      | Forecasting and budgeting                                 |
      | Foreign exchange                                          |
      | Mergers, acquisitions and divestment                      |
      | Payment structure advice and risk                         |
      | Risk management                                           |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I click on the 'Back' back link
    Then I am on the 'Select the services you need' page
    And the following items should appear in the basket:
      | Developing and assessing project proposals                |
      | Forecasting and budgeting                                 |
      | Financial performance review and viability studies        |
      | Foreign exchange                                          |
      | Debt restructuring, management and insolvency             |
      | Risk management                                           |
      | Business analysis                                         |
      | Mergers, acquisitions and divestment                      |
      | Payment structure advice and risk                         |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
      | Financing public infrastructure projects and negotiations |