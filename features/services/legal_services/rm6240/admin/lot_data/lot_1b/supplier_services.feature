Feature: Legal services - Admin - Supplier lot data - Lot 1b - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MERTZ-HOMENICK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MERTZ-HOMENICK'
    And I click on 'View services' for the lot 'Lot 1b - Full service provision (Scotland)'
    Then I am on the 'Lot 1b - Full service provision - Services' page
    And the caption is 'MERTZ-HOMENICK'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                   | Has service? |
      | Administrative and Public Law                  | No           |
      | Charities Law                                  | No           |
      | Children and Vulnerable Adults                 | No           |
      | Competition Law                                | Yes          |
      | Contracts                                      | Yes          |
      | Corporate Law                                  | No           |
      | Data Protection and Information Law            | No           |
      | Education Law                                  | Yes          |
      | Employment                                     | Yes          |
      | Energy, Natural Resources and Climate Change   | Yes          |
      | Food, Rural and Environmental Affairs          | Yes          |
      | Franchise Law                                  | No           |
      | Health and Safety                              | No           |
      | Health, Healthcare and Social Care             | No           |
      | Immigration                                    | Yes          |
      | Information Technology                         | Yes          |
      | Infrastructure                                 | Yes          |
      | Intellectual Property                          | Yes          |
      | International Trade, Investment and Regulation | No           |
      | Islamic Finance / Sukuk                        | Yes          |
      | Licensing Law                                  | No           |
      | Life Sciences                                  | Yes          |
      | Litigation and Dispute Resolution              | No           |
      | Media Law                                      | No           |
      | Mental Health Law                              | No           |
      | Non-Complex Finance and Investment             | Yes          |
      | Outsourcing / Insourcing                       | No           |
      | Partnerships                                   | No           |
      | Pensions                                       | No           |
      | Planning                                       | Yes          |
      | Projects                                       | No           |
      | Property, Real Estate and Construction         | Yes          |
      | Public Inquests and Inquiries                  | No           |
      | Public International Law                       | No           |
      | Public Procurement                             | Yes          |
      | Restructuring and Insolvency                   | Yes          |
      | Retained EU Law and EU Law                     | Yes          |
      | Tax                                            | Yes          |
      | Telecommunications                             | No           |
      | Transport Law (excluding Rail)                 | No           |
