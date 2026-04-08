Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Branches

  Scenario: Branches
    Given I sign in as an admin for the 'RM6376' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'NADER, CONN AND REINGER'
    Then I am on the 'Supplier lot data' page
    And the caption is 'NADER, CONN AND REINGER'
    And I click on 'View branches' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision View branches' page
    And the caption is 'NADER, CONN AND REINGER'
    And the branches in the table are:
      | Branch                  | Contact name         | Contact email                        | Phone number | Address                                                    |
      | Liverpool - Merseyside  | Rep. Meg Heidenreich | heidenreich_meg_rep@gleason.example  | 487-919-3732 | The Capital BuildingOld Hall StLiverpoolMerseysideL3 9PP   |
      | Nottingham - Nottingham | Magen Hermann        | hermann_magen@terry.example          | 816.366.3872 | Trent BridgeWest BridgfordNottinghamNottinghamshireNG2 6AG |
      | Southend-on-Sea - Essex | Deane Sipes Sr.      | sr_sipes_deane@mann-schamberger.test | 8212216569   | Roots HallVictoria AveSouthend-on-SeaEssexSS2 6NQ          |