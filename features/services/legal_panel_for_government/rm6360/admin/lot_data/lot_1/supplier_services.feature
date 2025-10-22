Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 1 - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BALISTRERI-MURAZIK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BALISTRERI-MURAZIK'
    And I click on 'View services' for the lot 'Lot 1 - Core Legal Services'
    Then I am on the 'Lot 1 - Core Legal Services - Services' page
    And the caption is 'BALISTRERI-MURAZIK'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                            | Has service? |
      | Assimilated Law                                         | No           |
      | Aviation and Airports                                   | No           |
      | Charities                                               | No           |
      | Children and Vulnerable Adults                          | No           |
      | Commercial Litigation and Dispute Resolution            | No           |
      | Competition Law                                         | No           |
      | Construction Law                                        | No           |
      | Contracts                                               | No           |
      | Corporate Law                                           | No           |
      | Education Law                                           | No           |
      | Employment Law                                          | No           |
      | Energy and Natural Resources                            | Yes          |
      | Environmental Law                                       | No           |
      | Finance and Investment                                  | No           |
      | Financial Services, Market and Competition Regulation   | No           |
      | Fintech Crypto Assets                                   | No           |
      | Food, Rural and Environmental Affairs                   | No           |
      | Franchise Law                                           | No           |
      | Grants                                                  | No           |
      | Health and Safety                                       | No           |
      | Health, Healthcare and Social Care                      | Yes          |
      | Housing Law                                             | Yes          |
      | Immigration                                             | No           |
      | Information Law including Data Protection Law           | No           |
      | Information Technology Law                              | Yes          |
      | Insurance and Reinsurance                               | No           |
      | Intellectual Property Law                               | No           |
      | International Trade                                     | Yes          |
      | Life Sciences                                           | No           |
      | Maritime and Shipping                                   | No           |
      | Media Law                                               | No           |
      | Merger & Acquisition Activity                           | Yes          |
      | Outsourcing                                             | Yes          |
      | Partnership Law                                         | Yes          |
      | Pensions Law                                            | Yes          |
      | Planning Law                                            | No           |
      | Private Law Litigation and Dispute Resolution           | No           |
      | Projects/PFI/PPP                                        | Yes          |
      | Public Inquiries - Support to Participants and Inquests | Yes          |
      | Public International Law                                | No           |
      | Public Law                                              | Yes          |
      | Public Law Litigation and dispute resolution            | No           |
      | Public Procurement Law                                  | No           |
      | Real Estate and Real Estate Finance                     | No           |
      | Restructuring/Insolvency                                | No           |
      | Supporting Public Inquiries                             | No           |
      | Sustainable Finance/ Green Finance                      | No           |
      | Tax Law                                                 | No           |
