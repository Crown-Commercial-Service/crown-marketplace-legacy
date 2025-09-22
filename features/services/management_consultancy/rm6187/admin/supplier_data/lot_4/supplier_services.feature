Feature: Management Consultancy - Admin - Supplier lot data - Lot 4 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6187' framework in 'management consultancy'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM-RODRIGUEZ'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM-RODRIGUEZ'
    And I click on 'View services' for the lot 'Lot 4 - Finance'
    Then I am on the 'Lot 4 - Finance - Services' page
    And the caption is 'VEUM-RODRIGUEZ'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                              | Has service? |
      | Actuarial services                                        | Yes          |
      | Asset management including valuation, sales and disposals | Yes          |
      | Business analysis                                         | Yes          |
      | Capital fundraising, derivatives and hedging              | Yes          |
      | Cash management                                           | Yes          |
      | Corporate restructuring and flotation                     | Yes          |
      | Cost benefit reviews, studies, analysis and evaluation    | Yes          |
      | Debt restructuring, management and insolvency             | Yes          |
      | Developing and assessing project proposals                | Yes          |
      | Economic analysis                                         | Yes          |
      | Financial accounting and/or reporting                     | Yes          |
      | Financial due diligence                                   | Yes          |
      | Financial performance review and viability studies        | Yes          |
      | Financing public infrastructure projects and negotiations | Yes          |
      | Forecasting and budgeting                                 | Yes          |
      | Foreign exchange                                          | Yes          |
      | Investment, financial advice and market services          | Yes          |
      | Mergers, acquisitions and divestment                      | Yes          |
      | Payment structure advice and risk                         | Yes          |
      | Pensions services                                         | Yes          |
      | Policy impact assessments                                 | Yes          |
      | Regulation and statutory requirements and/or reporting    | Yes          |
      | Risk management                                           | Yes          |
      | Tax including value added tax (VAT)                       | Yes          |
