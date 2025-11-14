Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4a - View rates

  Background: Go to rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'DICKI, QUITZON AND KUB'
    Then I am on the 'Supplier lot data' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'View rates' for the lot 'Lot 4a - Trade and Investment Negotiations'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View rates' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I should see rate tables for the following jurisdictions:
      | Algeria                                   |
      | American Samoa                            |
      | Angola                                    |
      | Anguilla                                  |
      | Antarctica                                |
      | Australia                                 |
      | Bangladesh                                |
      | Belarus                                   |
      | Benin                                     |
      | Bouvet Island                             |
      | British Virgin Islands                    |
      | Brunei                                    |
      | Cabo Verde                                |
      | Cambodia                                  |
      | China                                     |
      | Christmas Island                          |
      | Cocos (Keeling) Islands                   |
      | Cook Islands                              |
      | Croatia                                   |
      | Cuba                                      |
      | Curaçao                                   |
      | Czechia                                   |
      | Dominican Republic                        |
      | Equatorial Guinea                         |
      | Estonia                                   |
      | Ethiopia                                  |
      | Faroe Islands                             |
      | Finland                                   |
      | Gabon                                     |
      | Guinea                                    |
      | Guinea-Bissau                             |
      | Guyana                                    |
      | Honduras                                  |
      | Iceland                                   |
      | Indonesia                                 |
      | Iraq                                      |
      | Isle of Man                               |
      | Israel                                    |
      | Jersey                                    |
      | Kiribati                                  |
      | Kyrgyzstan                                |
      | Latvia                                    |
      | Lebanon                                   |
      | Liechtenstein                             |
      | Luxembourg                                |
      | Madagascar                                |
      | Maldives                                  |
      | Mali                                      |
      | Marshall Islands                          |
      | Mauritania                                |
      | Moldova                                   |
      | Montenegro                                |
      | Morocco                                   |
      | Namibia                                   |
      | Nauru                                     |
      | Nepal                                     |
      | Nicaragua                                 |
      | North Korea                               |
      | Northern Mariana Islands                  |
      | Panama                                    |
      | Paraguay                                  |
      | Peru                                      |
      | Puerto Rico                               |
      | Romania                                   |
      | Serbia                                    |
      | Sint Maarten (Dutch part)                 |
      | Solomon Islands                           |
      | South Korea                               |
      | South Sudan                               |
      | Sri Lanka                                 |
      | St Barthélemy                             |
      | St Helena, Ascension and Tristan da Cunha |
      | St Kitts and Nevis                        |
      | St Lucia                                  |
      | St Pierre and Miquelon                    |
      | State of Palestine                        |
      | Svalbard and Jan Mayen                    |
      | Taiwan                                    |
      | Tanzania                                  |
      | Trinidad and Tobago                       |
      | Turks and Caicos Islands                  |
      | Uganda                                    |
      | United Arab Emirates                      |
      | United Kingdom                            |
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |
    And the rates in the 'Benin' table are:
      | Grade                                                              | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £315.00 |
      | Partner                                                            | £280.00 |
      | Legal Director/Counsel or equivalent                               | £245.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £210.00 |
      | Solicitor, Associate/Legal Executive                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £140.00 |
      | Trainee/Legal Apprentice                                           | £84.00  |
      | Paralegal, Legal Assistant                                         | £70.00  |
      | Legal Project Managers                                             | £131.25 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £140.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £175.00 |
    And the rates in the 'Paraguay' table are:
      | Grade                                                              | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £270.00 |
      | Partner                                                            | £240.00 |
      | Legal Director/Counsel or equivalent                               | £210.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £180.00 |
      | Solicitor, Associate/Legal Executive                               | £150.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £120.00 |
      | Trainee/Legal Apprentice                                           | £72.00  |
      | Paralegal, Legal Assistant                                         | £60.00  |
      | Legal Project Managers                                             | £112.50 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £120.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £150.00 |
    And the rates in the 'United Kingdom' table are:
      | Grade                                                              | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £270.00 |
      | Partner                                                            | £240.00 |
      | Legal Director/Counsel or equivalent                               | £210.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £180.00 |
      | Solicitor, Associate/Legal Executive                               | £150.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £120.00 |
      | Trainee/Legal Apprentice                                           | £72.00  |
      | Paralegal, Legal Assistant                                         | £60.00  |
      | Legal Project Managers                                             | £112.50 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £120.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £150.00 |

  Scenario Outline: Rates validation
    Given I click on 'Change (Supplier rates for Paraguay)'
    Then I am on the 'Edit rates for Paraguay' page
    And the caption is 'DICKI, QUITZON AND KUB'
    Then I enter the following rates into the form:
      | Legal Director/Counsel or equivalent | <rate> |
    And I click on 'Save and return'
    Then I am on the 'Edit rates for Paraguay' page
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | rate        | error_message                                            |
      |             | You must enter a value for this rate                     |
      | Not a rate  | The rate must be formatted as money, for example £350.50 |
      | 55.5        | The rate must be formatted as money, for example £350.50 |
      | 10000000.00 | The rate must be less than £1,000,000                    |

  Scenario Outline: Set rates
    Given I click on 'Change (Supplier rates for <country>)'
    Then I am on the 'Edit rates for <country>' page
    And the caption is 'DICKI, QUITZON AND KUB'
    Then I enter the following rates into the form:
      | Senior Counsel, Senior Partner (20 years +PQE)                              | 1        |
      | Partner                                                                     | 10000.00 |
      | Legal Director/Counsel or equivalent                                        | 1000.00  |
      | Senior Solicitor, Senior Associate/Senior Legal Executive                   | 1000.00  |
      | Solicitor, Associate/Legal Executive                                        | 100.90   |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive          | 123      |
      | Trainee/Legal Apprentice                                                    | 456.78   |
      | Paralegal, Legal Assistant                                                  | 106      |
      | Legal Project Managers                                                      | 405.44   |
      | Senior Analyst (optional)                                                   |          |
      | Analyst, Associate Analyst, Research Associate, Research Officer (optional) |          |
      | Senior Modeller, Senior Econometrician, Senior Analyst (optional)           | 879.56   |
      | Modeller, Econometrician, Analyst, Associate Analyst (optional)             | 125.45   |
    And I click on 'Save and return'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View rates' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the rates in the '<country>' table are:
      | Grade                                                              | Hourly     |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £1.00      |
      | Partner                                                            | £10,000.00 |
      | Legal Director/Counsel or equivalent                               | £1,000.00  |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £1,000.00  |
      | Solicitor, Associate/Legal Executive                               | £100.90    |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £123.00    |
      | Trainee/Legal Apprentice                                           | £456.78    |
      | Paralegal, Legal Assistant                                         | £106.00    |
      | Legal Project Managers                                             | £405.44    |
      | Senior Modeller, Senior Econometrician, Senior Analyst             | £879.56    |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £125.45    |

    Examples:
      | country        |
      | Paraguay       |
      | United Kingdom |
