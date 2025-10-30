Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 2 - Srervices

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'CORMIER INC'
    Then I am on the 'Supplier lot data' page
    And the caption is 'CORMIER INC'
    And I click on 'View services' for the lot 'Lot 2 - Major Projects and Complex Advice'
    Then I am on the 'Lot 2 - Major Projects and Complex Advice View services' page
    And the caption is 'CORMIER INC'
    And the supplier should be assigned to the 'services' as follows:
      | Assimilated Law                                             |
      | Aviation and Airports                                       |
      | Charities                                                   |
      | Children and Vulnerable Adults                              |
      | Commercial Litigation and Dispute Resolution                |
      | Competition Law                                             |
      | Construction Law                                            |
      | Contracts                                                   |
      | Corporate Finance                                           |
      | Corporate Law                                               |
      | Credit Insurance and Related Products                       |
      | Debt Capital Markets                                        |
      | Education Law                                               |
      | Employment Law                                              |
      | Energy and Natural Resources                                |
      | Environmental Law                                           |
      | Equity Capital Markets                                      |
      | Finance and Investment                                      |
      | Financial Institutions Rescue, Restructuring and Insolvency |
      | Financial Services, Market and Competition Regulation       |
      | Fintech Crypto Assets                                       |
      | Food, Rural and Environmental Affairs                       |
      | Franchise Law                                               |
      | Grants                                                      |
      | Health and Safety                                           |
      | Health, Healthcare and Social Care                          |
      | Housing Law                                                 |
      | Immigration                                                 |
      | Information Law including Data Protection Law               |
      | Information Technology Law                                  |
      | Insurance and Reinsurance                                   |
      | Intellectual Property Law                                   |
      | International Development/Aid Funding                       |
      | International Finance Organisations                         |
      | International Trade                                         |
      | Investment and Asset Management                             |
      | Investment and Commercial Banking                           |
      | Islamic Finance / Sukuk                                     |
      | Life Sciences                                               |
      | Maritime and Shipping                                       |
      | Media Law                                                   |
      | Merger & Acquisition Activity                               |
      | Outsourcing                                                 |
      | Partnership Law                                             |
      | Pensions Law                                                |
      | Planning Law                                                |
      | Private Law Litigation and Dispute resolution               |
      | Project and Asset Finance                                   |
      | Projects/PFI/PPP                                            |
      | Public Inquiries - Support to Participants and Inquests     |
      | Public International Law                                    |
      | Public Law                                                  |
      | Public Law Litigation and Dispute Resolution                |
      | Public Procurement Law                                      |
      | Real Estate and Real Estate Finance                         |
      | Restructuring/Insolvency                                    |
      | Supporting Public Inquiries                                 |
      | Sustainable Finance / Green Finance                         |
      | Tax Law                                                     |
