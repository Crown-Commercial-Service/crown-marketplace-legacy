Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 5 - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WALKER-LEUSCHKE'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WALKER-LEUSCHKE'
    And I click on 'View services' for the lot 'Lot 5 - Rail Legal Services'
    Then I am on the 'Lot 5 - Rail Legal Services View services' page
    And the caption is 'WALKER-LEUSCHKE'
    And the supplier should be assigned to the 'services' as follows:
      | Dispute Resolution and litigation law         |
      | EU law                                        |
      | Employment law                                |
      | Environmental law                             |
      | Information law including data protection law |
      | Insurance law                                 |
      | Intellectual property law                     |
      | International law                             |
      | Public procurement law                        |
      | Rail Commercial Law                           |
      | Restructuring/ Insolvency law                 |
      | Subsidy Control Law                           |
      | Tax law                                       |
