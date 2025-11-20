Feature: Legal services - Admin - Supplier lot data - Lot 1b - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'MERTZ-HOMENICK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MERTZ-HOMENICK'
    And I click on 'View services' for the lot 'Lot 1b - Full service provision (Scotland)'
    Then I am on the 'Lot 1b - Full service provision View services' page
    And the caption is 'MERTZ-HOMENICK'
    And the supplier should be assigned to the 'services' as follows:
      | Competition Law                              |
      | Contracts                                    |
      | Education Law                                |
      | Employment                                   |
      | Energy, Natural Resources and Climate Change |
      | Food, Rural and Environmental Affairs        |
      | Immigration                                  |
      | Information Technology                       |
      | Infrastructure                               |
      | Intellectual Property                        |
      | Islamic Finance / Sukuk                      |
      | Life Sciences                                |
      | Non-Complex Finance and Investment           |
      | Planning                                     |
      | Property, Real Estate and Construction       |
      | Public Procurement                           |
      | Restructuring and Insolvency                 |
      | Retained EU Law and EU Law                   |
      | Tax                                          |
