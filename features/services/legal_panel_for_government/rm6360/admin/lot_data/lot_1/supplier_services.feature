Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 1 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BALISTRERI-MURAZIK'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BALISTRERI-MURAZIK'
    And I click on 'View services' for the lot 'Lot 1 - Core Legal Services'
    Then I am on the 'Lot 1 - Core Legal Services View services' page
    And the caption is 'BALISTRERI-MURAZIK'
    And the supplier should be assigned to the 'services' as follows:
      | Energy and Natural Resources                            |
      | Health, Healthcare and Social Care                      |
      | Housing Law                                             |
      | Information Technology Law                              |
      | International Trade                                     |
      | Merger & Acquisition Activity                           |
      | Outsourcing                                             |
      | Partnership Law                                         |
      | Pensions Law                                            |
      | Projects/PFI/PPP                                        |
      | Public Inquiries - Support to Participants and Inquests |
      | Public Law                                              |
