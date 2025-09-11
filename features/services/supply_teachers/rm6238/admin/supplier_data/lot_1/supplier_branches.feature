Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Branches

  Scenario: Branches
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I click on 'View branches' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision - Branches' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And the branches in the table are:
      | Branch                       | Contact name    | Contact email                | Phone number          | Address                                                   |
      | London - Inner London - East | Jae Bradtke JD  | jae_bradtke_jd@considine.org | 796.971.2756 x5567    | London StadiumQueen Elizabeth Olympic ParkLondonE20 2ST   |
      | Southport - Merseyside       | Fr. Theda Ratke | theda.fr.ratke@ortiz.com     | 1-239-638-8229 x18833 | Southport PleasurelandMarine DrSouthportMerseysidePR8 1RX |
