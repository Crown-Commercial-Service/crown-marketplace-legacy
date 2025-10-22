Feature: Legal services - Admin - Supplier lot data - Lot 2a - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'GUSIKOWSKI, BOSCO AND CRIST'
    Then I am on the 'Supplier lot data' page
    And the caption is 'GUSIKOWSKI, BOSCO AND CRIST'
    And I click on 'View services' for the lot 'Lot 2a - General service provision (England and Wales)'
    Then I am on the 'Lot 2a - General service provision - Services' page
    And the caption is 'GUSIKOWSKI, BOSCO AND CRIST'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Child Law                       | No           |
      | Court of Protection             | Yes          |
      | Debt Recovery                   | No           |
      | Education Law                   | No           |
      | Employment                      | Yes          |
      | Healthcare                      | Yes          |
      | Intellectual Property           | No           |
      | Licensing                       | Yes          |
      | Litigation / Dispute Resolution | Yes          |
      | Mental Health Law               | No           |
      | Pensions                        | Yes          |
      | Planning and Environment        | No           |
      | Primary Care                    | No           |
      | Property and Construction       | Yes          |
      | Social Housing                  | No           |
