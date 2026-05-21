Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4a - Jurisdictions

  Background: Go to jurisdictions
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'DICKI, QUITZON AND KUB'
    Then I am on the 'Supplier lot data' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'View jurisdictions' for the lot 'Lot 4a - Trade and Investment Negotiations'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
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
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |

  Scenario: Change jurisdictions - Add or remove - Validations
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'Continue'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And I should see the following error messages:
      | You must select add or remove |

  Scenario: Change jurisdictions - Select jurisdiction to add - Validations
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Add'
    And I click on 'Continue'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And I should see the following error messages:
      | You must select a jurisdiction to add |

  Scenario: Change jurisdictions - Select jurisdiction to remove - Validations
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Remove'
    And I click on 'Continue'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And I should see the following error messages:
      | You must select a jurisdiction to remove |

  Scenario Outline: Change jurisdictions - Add rates - Validations
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Add'
    And I select 'Ukraine' from 'Select jurisdiction to add'
    And I click on 'Continue'
    Then I am on the 'Add rates for the jurisdiction' page
    And the caption is 'DICKI, QUITZON AND KUB'
    Then I enter the following rates into the form:
      | Senior Counsel, Senior Partner (20 years +PQE)                     | 123    |
      | Partner                                                            | 123    |
      | Legal Director/Counsel or equivalent                               | <rate> |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | 123    |
      | Solicitor, Associate/Legal Executive                               | 123    |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | 123    |
      | Trainee/Legal Apprentice                                           | 123    |
      | Paralegal, Legal Assistant                                         | 123    |
    And I click on 'Add rates'
    And I should see the following error messages:
      | <error_message> |

    Examples:
      | rate        | error_message                                            |
      |             | You must enter a value for this rate                     |
      | Not a rate  | The rate must be formatted as money, for example £350.50 |
      | 55.5        | The rate must be formatted as money, for example £350.50 |
      | 10000000.00 | The rate must be less than £1,000,000                    |

  Scenario: Change jurisdictions - Add jurisdiction
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Add'
    And I select 'Ukraine' from 'Select jurisdiction to add'
    And I click on 'Continue'
    Then I am on the 'Add rates for the jurisdiction' page
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
      | Legal Project Managers (optional)                                           | 405.44   |
      | Senior Analyst (optional)                                                   |          |
      | Analyst, Associate Analyst, Research Associate, Research Officer (optional) |          |
      | Senior Modeller, Senior Econometrician, Senior Analyst (optional)           | 879.56   |
      | Modeller, Econometrician, Analyst, Associate Analyst (optional)             | 125.45   |
    And I click on 'Add rates'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I should see the following messgae in a 'success' notification banner:
      | Heading                                           |
      | The jurisdiction 'Ukraine' was added successfully |
    And I click on 'Cancel'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
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
      | Ukraine                                   |
      | United Arab Emirates                      |
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |
    And I click on 'Supplier lot data'
    And I click on 'View rates' for the lot 'Lot 4a - Trade and Investment Negotiations'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View rates' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the rates in the 'Ukraine' table are:
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

  Scenario: Change jurisdictions - Add jurisdiction - Cancel
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Add'
    And I select 'Ukraine' from 'Select jurisdiction to add'
    And I click on 'Continue'
    Then I am on the 'Add rates for the jurisdiction' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'Cancel'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'Cancel'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
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
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |

  Scenario: Change jurisdictions - Remove jurisdiction
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Remove'
    And I select 'Morocco' from 'Select jurisdiction to remove'
    And I click on 'Continue'
    Then I am on the 'Remove jurisdiction' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the following content should be displayed on the page:
      | Are you sure you want to remove the Morocco jurisdiction for the supplier?                                              |
      | This will remove their rates for this jurisdiction and they will no longer appear in the results for this jurisdiction. |
    And I click on 'Remove'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I should see the following messgae in a 'success' notification banner:
      | Heading                                             |
      | The jurisdiction 'Morocco' was removed successfully |
    And I click on 'Cancel'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
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
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |
    And I click on 'Supplier lot data'
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

  Scenario: Change jurisdictions - Add jurisdiction - Cancel
    Given I click on 'Change'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I select 'Remove'
    And I select 'Morocco' from 'Select jurisdiction to remove'
    And I click on 'Continue'
    Then I am on the 'Remove jurisdiction' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the following content should be displayed on the page:
      | Are you sure you want to remove the Morocco jurisdiction for the supplier?                                              |
      | This will remove their rates for this jurisdiction and they will no longer appear in the results for this jurisdiction. |
    And I click on 'Cancel'
    Then I am on the 'Add or a remove a jurisdiction from the supplier' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'Cancel'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations View jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
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
      | Vanuatu                                   |
      | Venezuela                                 |
      | Vietnam                                   |
      | Wallis and Futuna                         |
      | Western Sahara                            |
      | Zambia                                    |
