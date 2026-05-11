Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Branches

  Background: Go to branches
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
      | Liverpool - Merseyside  | Rep. Meg Heidenreich | heidenreich_meg_rep@gleason.example  | 04879193732  | The Capital BuildingOld Hall StLiverpoolMerseysideL3 9PP   |
      | Nottingham - Nottingham | Magen Hermann        | hermann_magen@terry.example          | 816.366.3872 | Trent BridgeWest BridgfordNottinghamNottinghamshireNG2 6AG |
      | Southend-on-Sea - Essex | Deane Sipes Sr.      | sr_sipes_deane@mann-schamberger.test | 8212216569   | Roots HallVictoria AveSouthend-on-SeaEssexSS2 6NQ          |
    Given I click on 'Change (Liverpool - Merseyside)'
    Then I am on the 'Edit branch' page
    And the caption is 'NADER, CONN AND REINGER'

  Scenario: Branches validation
    And I enter the following details into the form:
      | Name           |  |
      | Region         |  |
      | Contact name   |  |
      | Contact email  |  |
      | Phone number   |  |
      | Address line 1 |  |
      | Address line 2 |  |
      | Town           |  |
      | County         |  |
      | Postcode       |  |
    And I click on 'Save and return'
    Then I am on the 'Edit branch' page
    And I should see the following error messages:
      | The branch name cannot be blank                                      |
      | The branch region cannot be blank                                    |
      | The contact name cannot be blank                                     |
      | Enter the contact email in the correct format, like name@example.com |
      | Enter the phone number in the correct format, like 07700 900000      |
      | Address line 1 cannot be blank                                       |
      | The town cannot be blank                                             |
      | The postcode cannot be blank                                         |

  @geocode_liverpool
  Scenario Outline: Validations on the phone number
    And I enter the following details into the form:
      | Phone number | <phone_number> |
    And I click on 'Save and return'
    Then I am on the 'Edit branch' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | phone_number | error_message                                                   |
      | not number   | Enter the phone number in the correct format, like 07700 900000 |
      | 0712345678   | Enter the phone number in the correct format, like 07700 900000 |
      | 01 23 45 678 | Enter the phone number in the correct format, like 07700 900000 |

  @geocode_liverpool
  Scenario Outline: Validations on the postcode
    And I enter the following details into the form:
      | Postcode | <postcode> |
    And I click on 'Save and return'
    Then I am on the 'Edit branch' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | postcode      | error_message                                                                    |
      | Fake Postcode | Enter a valid postcode                                                           |
      | SW1 1AA       | No location could be found for this postcode, make sure it is a real UK postcode |

  @geocode_liverpool
  Scenario: Set branch
    And I enter the following details into the form:
      | Name           | Everton                   |
      | Region         | Liverpool                 |
      | Contact name   | Dixie Dean                |
      | Contact email  | dixie.deanean@everton.com |
      | Phone number   | 07123456789               |
      | Address line 1 | Hill Dickinson Stadium    |
      | Address line 2 | Regent Rd                 |
      | Town           | Liverpool                 |
      | County         | Merseyside                |
      | Postcode       | L24 1YD                   |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Direct provision View branches' page
    And the caption is 'NADER, CONN AND REINGER'
    And the branches in the table are:
      | Branch                  | Contact name    | Contact email                        | Phone number | Address                                                    |
      | Everton - Liverpool     | Dixie Dean      | dixie.deanean@everton.com            | 07123 456789 | Hill Dickinson StadiumRegent RdLiverpoolMerseysideL24 1YD  |
      | Nottingham - Nottingham | Magen Hermann   | hermann_magen@terry.example          | 816.366.3872 | Trent BridgeWest BridgfordNottinghamNottinghamshireNG2 6AG |
      | Southend-on-Sea - Essex | Deane Sipes Sr. | sr_sipes_deane@mann-schamberger.test | 8212216569   | Roots HallVictoria AveSouthend-on-SeaEssexSS2 6NQ          |
