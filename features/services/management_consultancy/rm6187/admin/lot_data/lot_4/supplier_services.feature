Feature: Management Consultancy - Admin - Supplier lot data - Lot 4 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM-RODRIGUEZ'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM-RODRIGUEZ'
    And I click on 'View services' for the lot 'Lot 4 - Finance'
    Then I am on the 'Lot 4 - Finance View services' page
    And the caption is 'VEUM-RODRIGUEZ'
    And the supplier should be assigned to the 'services' as follows:
      | Actuarial services                                        |
      | Asset management including valuation, sales and disposals |
      | Business analysis                                         |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Corporate restructuring and flotation                     |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Debt restructuring, management and insolvency             |
      | Developing and assessing project proposals                |
      | Economic analysis                                         |
      | Financial accounting and/or reporting                     |
      | Financial due diligence                                   |
      | Financial performance review and viability studies        |
      | Financing public infrastructure projects and negotiations |
      | Forecasting and budgeting                                 |
      | Foreign exchange                                          |
      | Investment, financial advice and market services          |
      | Mergers, acquisitions and divestment                      |
      | Payment structure advice and risk                         |
      | Pensions services                                         |
      | Policy impact assessments                                 |
      | Regulation and statutory requirements and/or reporting    |
      | Risk management                                           |
      | Tax including value added tax (VAT)                       |
