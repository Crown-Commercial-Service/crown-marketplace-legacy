Feature: Management Consultancy - Admin - Supplier lot data - Lot 4 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOHLER-STOKES'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOHLER-STOKES'
    And I click on 'View services' for the lot 'Lot 4 - Finance'
    Then I am on the 'Lot 4 - Finance View services' page
    And the caption is 'KOHLER-STOKES'
    And the supplier should be assigned to the 'services' as follows:
      | Asset management including valuation, sales and disposals |
      | Capital fundraising, derivatives and hedging              |
      | Cash management                                           |
      | Cost benefit reviews, studies, analysis and evaluation    |
      | Developing and assessing project proposals                |
      | Financial accounting and/or reporting                     |
      | Financial due diligence                                   |
      | Financial performance review and viability studies        |
      | Financing public projects and negotiations                |
      | Forecasting and budgeting                                 |
      | Payment structure advice and risk                         |
      | Pensions                                                  |
      | Regulation and statutory requirements                     |
      | Tax including value added tax (VAT)                       |
