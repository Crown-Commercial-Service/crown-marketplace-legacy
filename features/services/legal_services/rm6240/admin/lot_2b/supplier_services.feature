Feature: Legal services - Admin - Supplier lot data - Lot 2b - Services

  Scenario: Services
    Given I sign in as an admin for the 'RM6240' framework in 'legal services'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'WEHNER, STEHR AND KULAS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And I click on 'View services' for the lot 'Lot 2b - General service provision (Scotland)'
    Then I am on the 'Lot 2b - General service provision - Services' page
    And the caption is 'WEHNER, STEHR AND KULAS'
    And the supplier should be assigned to the 'services' as follows:
      | Service name                    | Has service? |
      | Child Law                       | No           |
      | Court of Protection             | No           |
      | Debt Recovery                   | No           |
      | Education Law                   | No           |
      | Employment                      | Yes          |
      | Healthcare                      | Yes          |
      | Intellectual Property           | No           |
      | Licensing                       | No           |
      | Litigation / Dispute Resolution | No           |
      | Mental Health Law               | Yes          |
      | Pensions                        | No           |
      | Planning and Environment        | Yes          |
      | Primary Care                    | Yes          |
      | Property and Construction       | No           |
      | Social Housing                  | Yes          |
