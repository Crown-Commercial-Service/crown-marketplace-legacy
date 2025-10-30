Feature: Legal services - Admin - Supplier lot data - Lot 2c - View services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREUTEL, GERLACH AND SPORER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREUTEL, GERLACH AND SPORER'
    And I click on 'View services' for the lot 'Lot 2c - General service provision (Northern Ireland)'
    Then I am on the 'Lot 2c - General service provision View services' page
    And the caption is 'TREUTEL, GERLACH AND SPORER'
    And the supplier should be assigned to the 'services' as follows:
      | Child Law                       |
      | Court of Protection             |
      | Debt Recovery                   |
      | Education Law                   |
      | Employment                      |
      | Healthcare                      |
      | Intellectual Property           |
      | Licensing                       |
      | Litigation / Dispute Resolution |
      | Mental Health Law               |
      | Pensions                        |
      | Planning and Environment        |
      | Primary Care                    |
      | Property and Construction       |
      | Social Housing                  |
