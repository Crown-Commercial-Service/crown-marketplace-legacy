Feature: Legal services - Admin - Supplier lot data - Lot 1a - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'LEDNER, BAILEY AND WEISSNAT'
    Then I am on the 'Supplier lot data' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And I click on 'View services' for the lot 'Lot 1a - Full service provision (England and Wales)'
    Then I am on the 'Lot 1a - Full service provision View services' page
    And the caption is 'LEDNER, BAILEY AND WEISSNAT'
    And the supplier should be assigned to the 'services' as follows:
      | Administrative and Public Law                  |
      | Children and Vulnerable Adults                 |
      | Corporate Law                                  |
      | Data Protection and Information Law            |
      | Franchise Law                                  |
      | Health and Safety                              |
      | Information Technology                         |
      | Intellectual Property                          |
      | International Trade, Investment and Regulation |
      | Life Sciences                                  |
      | Mental Health Law                              |
      | Outsourcing / Insourcing                       |
      | Pensions                                       |
      | Planning                                       |
      | Property, Real Estate and Construction         |
      | Public Inquests and Inquiries                  |
      | Public International Law                       |
      | Public Procurement                             |
      | Tax                                            |
      | Transport Law (excluding Rail)                 |
