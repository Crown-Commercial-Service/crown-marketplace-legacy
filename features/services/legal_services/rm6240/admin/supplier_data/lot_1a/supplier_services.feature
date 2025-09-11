Feature: Legal services - Admin - Supplier lot data - Lot 1a - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'LEDNER, BAILEY AND WEISSNAT'
    Then I am on the 'Supplier lot data' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And I click on 'View services' for the lot 'Lot 1a - Full service provision (England and Wales)'
    Then I am on the 'Lot 1a - Full service provision - Services' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                                   | Has service? |
      | Administrative and Public Law                  | Yes          |
      | Charities Law                                  | No           |
      | Children and Vulnerable Adults                 | Yes          |
      | Competition Law                                | No           |
      | Contracts                                      | No           |
      | Corporate Law                                  | Yes          |
      | Data Protection and Information Law            | Yes          |
      | Education Law                                  | No           |
      | Employment                                     | No           |
      | Energy, Natural Resources and Climate Change   | No           |
      | Food, Rural and Environmental Affairs          | No           |
      | Franchise Law                                  | Yes          |
      | Health and Safety                              | Yes          |
      | Health, Healthcare and Social Care             | No           |
      | Immigration                                    | No           |
      | Information Technology                         | Yes          |
      | Infrastructure                                 | No           |
      | Intellectual Property                          | Yes          |
      | International Trade, Investment and Regulation | Yes          |
      | Islamic Finance / Sukuk                        | No           |
      | Licensing Law                                  | No           |
      | Life Sciences                                  | Yes          |
      | Litigation and Dispute Resolution              | No           |
      | Media Law                                      | No           |
      | Mental Health Law                              | Yes          |
      | Non-Complex Finance and Investment             | No           |
      | Outsourcing / Insourcing                       | Yes          |
      | Partnerships                                   | No           |
      | Pensions                                       | Yes          |
      | Planning                                       | Yes          |
      | Projects                                       | No           |
      | Property, Real Estate and Construction         | Yes          |
      | Public Inquests and Inquiries                  | Yes          |
      | Public International Law                       | Yes          |
      | Public Procurement                             | Yes          |
      | Restructuring and Insolvency                   | No           |
      | Retained EU Law and EU Law                     | No           |
      | Tax                                            | Yes          |
      | Telecommunications                             | No           |
      | Transport Law (excluding Rail)                 | Yes          |
