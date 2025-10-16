Feature: Management Consultancy - Lot 4 - Finance - Service selection

  Scenario: The correct options are available
    Given I sign in and navigate to the start page for the 'RM6309' framework in 'management consultancy'
    Given I select 'Lot 4 - Finance'
    And I click on 'Continue'
    Then I am on the 'Select the services you need' page
    And the sub title is 'MCF4 lot 4 - Finance'
    Then I should see the following options for the lot:
      | Asset finance                                             |
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
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
      | Tax including value added tax (VAT)                       |
