Feature: Supply Teachers - Admin - View supplier data pages

  Background: Navigate to supplier data page
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page

  @javascript
  Scenario: Supplier data page
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOGAN, REICHERT AND COLLIER  |
      | BOYLE, KOEPP AND TURNER      |
      | BRAUN INC                    |
      | CHRISTIANSEN INC             |
      | CORKERY INC                  |
      | DIETRICH-BORER               |
      | EMARD AND SONS               |
      | FEEST-MULLER                 |
      | HAGENES-BECHTELAR            |
      | KERLUKE, TORP AND HEATHCOTE  |
      | LEFFLER AND SONS             |
      | LUETTGEN-GUTMANN             |
      | MCGLYNN GROUP                |
      | MCGLYNN, BAILEY AND NIKOLAUS |
      | O'HARA LLC                   |
      | STANTON, FADEL AND BOSCO     |
      | ZIEMANN-HERMANN              |
    And I enter "ko" for the supplier search
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOYLE, KOEPP AND TURNER      |
      | MCGLYNN, BAILEY AND NIKOLAUS |
    And I enter "" for the supplier search
    Then I should see the following suppliers on the page:
      | BARTOLETTI, KOEPP AND NIENOW |
      | BOGAN, REICHERT AND COLLIER  |
      | BOYLE, KOEPP AND TURNER      |
      | BRAUN INC                    |
      | CHRISTIANSEN INC             |
      | CORKERY INC                  |
      | DIETRICH-BORER               |
      | EMARD AND SONS               |
      | FEEST-MULLER                 |
      | HAGENES-BECHTELAR            |
      | KERLUKE, TORP AND HEATHCOTE  |
      | LEFFLER AND SONS             |
      | LUETTGEN-GUTMANN             |
      | MCGLYNN GROUP                |
      | MCGLYNN, BAILEY AND NIKOLAUS |
      | O'HARA LLC                   |
      | STANTON, FADEL AND BOSCO     |
      | ZIEMANN-HERMANN              |

  Scenario Outline: Supplier details page
    And I click on 'View details' for "<supplier_name>"
    Then I am on the 'Supplier details' page
    And the caption is "<supplier_name>"
    And I should see the following details in the 'Supplier information' summary:
      | Name | <supplier_name> |

    Examples:
      | supplier_name    |
      | CHRISTIANSEN INC |
      | EMARD AND SONS   |
      | O'HARA LLC       |

  Scenario: Lot status - Lot 1
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Active        |
      | Rates      | View rates    |
      | Branches   | View branches |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Not on lot |

  Scenario: Lot status - Lot 2
    And I click on 'View lot data' for "O'HARA LLC"
    Then I am on the 'Supplier lot data' page
    And the caption is "O'HARA LLC"
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Active     |
      | Rates      | View rates |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Active     |
      | Rates      | View rates |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Not on lot |

  Scenario: Lot status - Lot 4
    And I click on 'View lot data' for 'BOYLE, KOEPP AND TURNER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BOYLE, KOEPP AND TURNER'
    And I should see the following details in the summary for the lot 'Lot 1 - Direct provision':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 2.1 - Master vendor (less than 2.5 million)':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 2.2 - Master vendor (more than 2.5 million)':
      | Lot status | Not on lot |
    And I should see the following details in the summary for the lot 'Lot 4 - Education technology platforms':
      | Lot status | Active     |
      | Rates      | View rates |
