Feature: Supply Teachers - Admin - View supplier data pages

  Background: Navigate to supplier data page
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page

  @javascript
  Scenario: Supplier data page
    Then I should see the following suppliers on the page:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | LANG INC                   |
      | MORAR, SHIELDS AND GIBSON  |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROLFSON-COLLIER            |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |
    And I enter "ha" for the supplier search
    Then I should see the following suppliers on the page:
      | DARE-ROHAN   |
      | FRITSCH-HAHN |
      | ROHAN LLC    |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | DANIEL AND SONS            |
      | DARE-ROHAN                 |
      | FRITSCH-HAHN               |
      | GLOVER-ONDRICKA            |
      | GRADY AND SONS             |
      | GULGOWSKI-HUDSON           |
      | HEANEY GROUP               |
      | LANG INC                   |
      | MORAR, SHIELDS AND GIBSON  |
      | NADER, CONN AND REINGER    |
      | ROHAN LLC                  |
      | ROLFSON-COLLIER            |
      | ROOB, CORWIN AND DICKI     |
      | ROSENBAUM-HINTZ            |
      | SATTERFIELD AND SONS       |
      | SWANIAWSKI, CORWIN AND KUB |
      | TILLMAN-EMMERICH           |
      | TREMBLAY-WEST              |

  Scenario Outline: Supplier details page
    And I click on 'View details' for "<supplier_name>"
    Then I am on the 'Supplier details' page
    And the caption is "<supplier_name>"
    And I should see the following details in the 'Supplier information' summary:
      | Name                  | <supplier_name>         |
      | Trading name          | <trading_name>          |
      | Additional identifier | <additional_identifier> |

    Examples:
      | supplier_name             | trading_name              | additional_identifier                |
      | DARE-ROHAN                | DARE-ROHAN                | 8d80d95b-fb86-4daa-8d58-4b12f8d6dab6 |
      | MORAR, SHIELDS AND GIBSON | MORAR, SHIELDS AND GIBSON | c0565138-6335-40b5-a3ff-d208ae6425c6 |
      | TILLMAN-EMMERICH          | CONN-MOEN                 | 85cde301-4305-4b5e-a973-f5e4bb851217 |

  Scenario: Lot status - Lot 1
    And I click on 'View lot data' for 'DANIEL AND SONS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'DANIEL AND SONS'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Enabled       |
      | Rates      | View rates    |
      | Branches   | View branches |
    And I should see the following details in the summary for the lot 'Lot 2 - Managed service provider':
      | Lot status | Not on lot |

  Scenario: Lot status - Lot 2
    And I click on 'View lot data' for 'MORAR, SHIELDS AND GIBSON'
    Then I am on the 'Supplier lot data' page
    And the caption is 'MORAR, SHIELDS AND GIBSON'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 2 - Managed service provider':
      | Lot status | Enabled    |
      | Rates      | View rates |
