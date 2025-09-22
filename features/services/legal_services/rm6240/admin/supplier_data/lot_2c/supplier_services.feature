Feature: Legal services - Admin - Supplier lot data - Lot 2c - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'TREUTEL, GERLACH AND SPORER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'TREUTEL, GERLACH AND SPORER'
    And I click on 'View services' for the lot 'Lot 2c - General service provision (Northern Ireland)'
    Then I am on the 'Lot 2c - General service provision - Services' page
    And the caption is 'TREUTEL, GERLACH AND SPORER'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Child Law                       | Yes          |
      | Court of Protection             | Yes          |
      | Debt Recovery                   | Yes          |
      | Education Law                   | Yes          |
      | Employment                      | Yes          |
      | Healthcare                      | Yes          |
      | Intellectual Property           | Yes          |
      | Licensing                       | Yes          |
      | Litigation / Dispute Resolution | Yes          |
      | Mental Health Law               | Yes          |
      | Pensions                        | Yes          |
      | Planning and Environment        | Yes          |
      | Primary Care                    | Yes          |
      | Property and Construction       | Yes          |
      | Social Housing                  | Yes          |
