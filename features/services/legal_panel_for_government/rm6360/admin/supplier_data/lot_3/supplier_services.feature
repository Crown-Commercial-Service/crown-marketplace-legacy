Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 3 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'SANFORD INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'SANFORD INC'
    And I click on 'View services' for the lot 'Lot 3 - Finance and High Risk/Innovation'
    Then I am on the 'Lot 3 - Finance and High Risk/Innovation - Services' page
    And the caption is 'SANFORD INC'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                | Has service? |
      | Corporate Finance                                           | No           |
      | Corporate Law                                               | No           |
      | Credit Insurance and Related Products                       | Yes          |
      | Debt Capital Markets                                        | Yes          |
      | Energy and Natural Resources                                | No           |
      | Equity Capital Markets                                      | No           |
      | Financial Institutions Rescue, Restructuring and Insolvency | No           |
      | Financial Services, Market and Competition Regulation       | No           |
      | Fintech Crypto Assets                                       | No           |
      | Insurance and Reinsurance                                   | No           |
      | International Development/Aid Funding                       | No           |
      | International Finance Organisations                         | No           |
      | Investment and Asset Management                             | No           |
      | Investment and Commercial Banking                           | Yes          |
      | Islamic Finance / Sukuk                                     | No           |
      | Litigation and Dispute Resolution                           | No           |
      | Merger and Acquisition Activity                             | Yes          |
      | Project and Asset Finance                                   | No           |
      | Projects and transactions                                   | Yes          |
      | Restructuring/Insolvency                                    | Yes          |
      | Sovereign Debt Restructuring                                | No           |
      | Sustainable Finance/ Green Finance                          | Yes          |
      | United State Securities & Regulatory                        | No           |
