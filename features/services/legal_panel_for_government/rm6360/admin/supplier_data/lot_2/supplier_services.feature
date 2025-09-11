Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 2 - Srervices

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CORMIER INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CORMIER INC'
    And I click on 'View services' for the lot 'Lot 2 - Major Projects and Complex Advice'
    Then I am on the 'Lot 2 - Major Projects and Complex Advice - Services' page
    And the caption is 'CORMIER INC'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                                | Has service? |
      | Assimilated Law                                             | Yes          |
      | Aviation and Airports                                       | Yes          |
      | Charities                                                   | Yes          |
      | Children and Vulnerable Adults                              | Yes          |
      | Commercial Litigation and Dispute Resolution                | Yes          |
      | Competition Law                                             | Yes          |
      | Construction Law                                            | Yes          |
      | Contracts                                                   | Yes          |
      | Corporate Finance                                           | Yes          |
      | Corporate Law                                               | Yes          |
      | Credit Insurance and Related Products                       | Yes          |
      | Debt Capital Markets                                        | Yes          |
      | Education Law                                               | Yes          |
      | Employment Law                                              | Yes          |
      | Energy and Natural Resources                                | Yes          |
      | Environmental Law                                           | Yes          |
      | Equity Capital Markets                                      | Yes          |
      | Finance and Investment                                      | Yes          |
      | Financial Institutions Rescue, Restructuring and Insolvency | Yes          |
      | Financial Services, Market and Competition Regulation       | Yes          |
      | Fintech Crypto Assets                                       | Yes          |
      | Food, Rural and Environmental Affairs                       | Yes          |
      | Franchise Law                                               | Yes          |
      | Grants                                                      | Yes          |
      | Health and Safety                                           | Yes          |
      | Health, Healthcare and Social Care                          | Yes          |
      | Housing Law                                                 | Yes          |
      | Immigration                                                 | Yes          |
      | Information Law including Data Protection Law               | Yes          |
      | Information Technology Law                                  | Yes          |
      | Insurance and Reinsurance                                   | Yes          |
      | Intellectual Property Law                                   | Yes          |
      | International Development/Aid Funding                       | Yes          |
      | International Finance Organisations                         | Yes          |
      | International Trade                                         | Yes          |
      | Investment and Asset Management                             | Yes          |
      | Investment and Commercial Banking                           | Yes          |
      | Islamic Finance / Sukuk                                     | Yes          |
      | Life Sciences                                               | Yes          |
      | Maritime and Shipping                                       | Yes          |
      | Media Law                                                   | Yes          |
      | Merger & Acquisition Activity                               | Yes          |
      | Outsourcing                                                 | Yes          |
      | Partnership Law                                             | Yes          |
      | Pensions Law                                                | Yes          |
      | Planning Law                                                | Yes          |
      | Private Law Litigation and Dispute resolution               | Yes          |
      | Project and Asset Finance                                   | Yes          |
      | Projects/PFI/PPP                                            | Yes          |
      | Public Inquiries - Support to Participants and Inquests     | Yes          |
      | Public International Law                                    | Yes          |
      | Public Law                                                  | Yes          |
      | Public Law Litigation and Dispute Resolution                | Yes          |
      | Public Procurement Law                                      | Yes          |
      | Real Estate and Real Estate Finance                         | Yes          |
      | Restructuring/Insolvency                                    | Yes          |
      | Supporting Public Inquiries                                 | Yes          |
      | Sustainable Finance / Green Finance                         | Yes          |
      | Tax Law                                                     | Yes          |
