Feature: Supply Teachers - Admin - Supplier lot data - Lot 1 - Branches

  Background: Go to branches
    Given I sign in as an admin for the 'RM6238' framework in 'supply teachers'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'BARTOLETTI, KOEPP AND NIENOW'
    Then I am on the 'Supplier lot data' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And I click on 'View branches' for the lot 'Lot 1 - Direct provision'
    Then I am on the 'Lot 1 - Direct provision View branches' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And the branches in the table are:
      | Branch                       | Contact name    | Contact email                | Phone number          | Address                                                   |
      | London - Inner London - East | Jae Bradtke JD  | jae_bradtke_jd@considine.org | 07969 712756          | London StadiumQueen Elizabeth Olympic ParkLondonE20 2ST   |
      | Southport - Merseyside       | Fr. Theda Ratke | theda.fr.ratke@ortiz.com     | 1-239-638-8229 x18833 | Southport PleasurelandMarine DrSouthportMerseysidePR8 1RX |
    Given I click on 'Change (London - Inner London - East)'
    Then I am on the 'Edit branch' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'

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

  @geocode_london
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

  @geocode_london
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

  @geocode_london
  Scenario: Set branch
    And I enter the following details into the form:
      | Name           | Chelsea                   |
      | Region         | London                    |
      | Contact name   | Frank Lampard             |
      | Contact email  | frank.lampard@chelsea.com |
      | Phone number   | 07123456789               |
      | Address line 1 | Stamford Bridge           |
      | Address line 2 | Fulham Broadway           |
      | Town           | Fulham                    |
      | County         | Greater London            |
      | Postcode       | SW1A 1AA                  |
    And I click on 'Save and return'
    Then I am on the 'Lot 1 - Direct provision View branches' page
    And the caption is 'BARTOLETTI, KOEPP AND NIENOW'
    And the branches in the table are:
      | Branch                 | Contact name    | Contact email             | Phone number          | Address                                                    |
      | Chelsea - London       | Frank Lampard   | frank.lampard@chelsea.com | 07123 456789          | Stamford BridgeFulham BroadwayFulhamGreater LondonSW1A 1AA |
      | Southport - Merseyside | Fr. Theda Ratke | theda.fr.ratke@ortiz.com  | 1-239-638-8229 x18833 | Southport PleasurelandMarine DrSouthportMerseysidePR8 1RX  |
