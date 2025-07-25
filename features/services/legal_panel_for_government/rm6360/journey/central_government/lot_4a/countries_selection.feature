@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 4a - Select countries

  Background: Navigate to start page and select the lot
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Do you work for central government?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4a - Trade and Investment Negotiations'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countires for your requirement' page
    And the sub title is 'Lot 4a - Trade and Investment Negotiations'

  Scenario: The correct options are available
    Then I should see the following options for the lot:
      | Afghanistan                                  |
      | Albania                                      |
      | Algeria                                      |
      | American Samoa                               |
      | Andorra                                      |
      | Angola                                       |
      | Anguilla                                     |
      | Antarctica                                   |
      | Antigua and Barbuda                          |
      | Argentina                                    |
      | Armenia                                      |
      | Aruba                                        |
      | Australia                                    |
      | Austria                                      |
      | Azerbaijan                                   |
      | Bahrain                                      |
      | Bangladesh                                   |
      | Barbados                                     |
      | Belarus                                      |
      | Belize                                       |
      | Benin                                        |
      | Bermuda                                      |
      | Bhutan                                       |
      | Bolivia                                      |
      | Bonaire, Sint Eustatius and Saba             |
      | Bosnia and Herzegovina                       |
      | Botswana                                     |
      | Bouvet Island                                |
      | Brazil                                       |
      | British Indian Ocean Territory               |
      | British Virgin Islands                       |
      | Brunei                                       |
      | Bulgaria                                     |
      | Burkina Faso                                 |
      | Burundi                                      |
      | Cabo Verde                                   |
      | Cambodia                                     |
      | Cameroon                                     |
      | Cayman Islands                               |
      | Central African Republic                     |
      | Chad                                         |
      | Chile                                        |
      | China                                        |
      | Christmas Island                             |
      | Cocos (Keeling) Islands                      |
      | Colombia                                     |
      | Comoros                                      |
      | Congo                                        |
      | Congo (Democratic Republic)                  |
      | Cook Islands                                 |
      | Costa Rica                                   |
      | Croatia                                      |
      | Cuba                                         |
      | Curaçao                                      |
      | Cyprus                                       |
      | Czechia                                      |
      | Côte d'Ivoire                                |
      | Denmark                                      |
      | Djibouti                                     |
      | Dominica                                     |
      | Dominican Republic                           |
      | Ecuador                                      |
      | Egypt                                        |
      | El Salvador                                  |
      | Equatorial Guinea                            |
      | Eritrea                                      |
      | Estonia                                      |
      | Eswatini                                     |
      | Ethiopia                                     |
      | Falkland Islands                             |
      | Faroe Islands                                |
      | Federated States of Micronesia               |
      | Fiji                                         |
      | Finland                                      |
      | French Guiana                                |
      | French Polynesia                             |
      | French Southern Territories                  |
      | Gabon                                        |
      | Georgia                                      |
      | Ghana                                        |
      | Gibraltar                                    |
      | Greece                                       |
      | Greenland                                    |
      | Grenada                                      |
      | Guadeloupe                                   |
      | Guam                                         |
      | Guatemala                                    |
      | Guernsey                                     |
      | Guinea                                       |
      | Guinea-Bissau                                |
      | Guyana                                       |
      | Haiti                                        |
      | Heard Island and McDonald Islands            |
      | Honduras                                     |
      | Hong Kong                                    |
      | Hungary                                      |
      | Iceland                                      |
      | India                                        |
      | Indonesia                                    |
      | Iran                                         |
      | Iraq                                         |
      | Isle of Man                                  |
      | Israel                                       |
      | Italy                                        |
      | Jamaica                                      |
      | Japan                                        |
      | Jersey                                       |
      | Jordan                                       |
      | Kazakhstan                                   |
      | Kenya                                        |
      | Kiribati                                     |
      | Kuwait                                       |
      | Kyrgyzstan                                   |
      | Laos                                         |
      | Latvia                                       |
      | Lebanon                                      |
      | Lesotho                                      |
      | Liberia                                      |
      | Libya                                        |
      | Liechtenstein                                |
      | Lithuania                                    |
      | Luxembourg                                   |
      | Macao                                        |
      | Madagascar                                   |
      | Malawi                                       |
      | Malaysia                                     |
      | Maldives                                     |
      | Mali                                         |
      | Malta                                        |
      | Marshall Islands                             |
      | Martinique                                   |
      | Mauritania                                   |
      | Mauritius                                    |
      | Mayotte                                      |
      | Mexico                                       |
      | Moldova                                      |
      | Monaco                                       |
      | Mongolia                                     |
      | Montenegro                                   |
      | Montserrat                                   |
      | Morocco                                      |
      | Mozambique                                   |
      | Myanmar (Burma)                              |
      | Namibia                                      |
      | Nauru                                        |
      | Nepal                                        |
      | Netherlands                                  |
      | New Caledonia                                |
      | New Zealand                                  |
      | Nicaragua                                    |
      | Niger                                        |
      | Nigeria                                      |
      | Niue                                         |
      | Norfolk Island                               |
      | North Korea                                  |
      | North Macedonia                              |
      | Northern Mariana Islands                     |
      | Norway                                       |
      | Oman                                         |
      | Pakistan                                     |
      | Palau                                        |
      | Panama                                       |
      | Papua New Guinea                             |
      | Paraguay                                     |
      | Peru                                         |
      | Philippines                                  |
      | Pitcairn                                     |
      | Poland                                       |
      | Portugal                                     |
      | Puerto Rico                                  |
      | Qatar                                        |
      | Romania                                      |
      | Russia                                       |
      | Rwanda                                       |
      | Réunion                                      |
      | Samoa                                        |
      | San Marino                                   |
      | Sao Tome and Principe                        |
      | Saudi Arabia                                 |
      | Senegal                                      |
      | Serbia                                       |
      | Seychelles                                   |
      | Sierra Leone                                 |
      | Sint Maarten (Dutch part)                    |
      | Slovakia                                     |
      | Slovenia                                     |
      | Solomon Islands                              |
      | Somalia                                      |
      | South Africa                                 |
      | South Georgia and the South Sandwich Islands |
      | South Korea                                  |
      | South Sudan                                  |
      | Spain                                        |
      | Sri Lanka                                    |
      | St Barthélemy                                |
      | St Helena, Ascension and Tristan da Cunha    |
      | St Kitts and Nevis                           |
      | St Lucia                                     |
      | St Martin (French part)                      |
      | St Pierre and Miquelon                       |
      | St Vincent and the Grenadines                |
      | State of Palestine                           |
      | Sudan                                        |
      | Suriname                                     |
      | Svalbard and Jan Mayen                       |
      | Sweden                                       |
      | Syria                                        |
      | Taiwan                                       |
      | Tajikistan                                   |
      | Tanzania                                     |
      | Thailand                                     |
      | The Bahamas                                  |
      | The Gambia                                   |
      | Timor-Leste                                  |
      | Togo                                         |
      | Tokelau                                      |
      | Tonga                                        |
      | Trinidad and Tobago                          |
      | Tunisia                                      |
      | Turkey                                       |
      | Turkmenistan                                 |
      | Turks and Caicos Islands                     |
      | Tuvalu                                       |
      | Uganda                                       |
      | Ukraine                                      |
      | United Arab Emirates                         |
      | United States Minor Outlying Islands         |
      | United States Virgin Island                  |
      | Uruguay                                      |
      | Uzbekistan                                   |
      | Vanuatu                                      |
      | Vatican City                                 |
      | Venezuela                                    |
      | Vietnam                                      |
      | Wallis and Futuna                            |
      | Western Sahara                               |
      | Yemen                                        |
      | Zambia                                       |
      | Zimbabwe                                     |
      | Åland Islands                                |

  Scenario: Country selection appears in basked
    Then the basket should say 'No countries selected'
    And the remove all link should not be visible
    When I check 'Afghanistan'
    Then the basket should say '1 country selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Afghanistan   |
    When I check the following items:
      | Colombia      |
      | Gabon         |
      | Macao         |
      | Panama        |
      | Vatican City  |
      | Zimbabwe      |
    Then the basket should say '7 countries selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Afghanistan   |
      | Colombia      |
      | Gabon         |
      | Macao         |
      | Panama        |
      | Vatican City  |
      | Zimbabwe      |

  Scenario: Changing the selection will change the basket
    When I check the following items:
      | Antarctica    |
      | French Guiana |
      | Hong Kong     |
      | Madagascar    |
      | Suriname      |
      | Taiwan        |
    Then the basket should say '6 countries selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Antarctica    |
      | French Guiana |
      | Hong Kong     |
      | Madagascar    |
      | Suriname      |
      | Taiwan        |
    When I deselect the following items:
      | Taiwan        |
    Then the basket should say '5 countries selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Antarctica    |
      | French Guiana |
      | Hong Kong     |
      | Madagascar    |
      | Suriname      |
    When I remove the following items from the basket:
      | Madagascar    |
      | Suriname      |
    Then the basket should say '3 countries selected'
    And the remove all link should be visible
    And the following items should appear in the basket:
      | Antarctica    |
      | French Guiana |
      | Hong Kong     |
    When I click on 'Remove all'
    Then the basket should say 'No countries selected'

  Scenario: Go back from services and change selection
    When I check the following items:
      | Madagascar  |
      | Tonga       |
      | Tunisia     |
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the countires for your requirement' page
    And the following items should appear in the basket:
      | Madagascar  |
      | Tonga       |
      | Tunisia     |

  Scenario: Search for a country
    When I type the following details into the form:
      | Start typing to find a country  | as |
    Then I should see the following options for the lot:
      | Burkina Faso                              |
      | Christmas Island                          |
      | Honduras                                  |
      | Madagascar                                |
      | St Helena, Ascension and Tristan da Cunha |
      | The Bahamas                               |
    When I enter the following details into the form:
      | Start typing to find a country  | |
    When I type the following details into the form:
      | Start typing to find a country  | AS |
    Then I should see the following options for the lot:
      | Burkina Faso                              |
      | Christmas Island                          |
      | Honduras                                  |
      | Madagascar                                |
      | St Helena, Ascension and Tristan da Cunha |
      | The Bahamas                               |
    When I enter the following details into the form:
      | Start typing to find a country  | |
    When I type the following details into the form:
      | Start typing to find a country  | Brit |
    Then I should see the following options for the lot:
      | British Indian Ocean Territory  |
      | British Virgin Islands          |
    When I type the following details into the form:
      | Start typing to find a country  | ishi  |
    Then I should see the following options for the lot:
      | British Indian Ocean Territory  |
    When I enter the following details into the form:
      | Start typing to find a country  | |
    When I type the following details into the form:
      | Start typing to find a country  | Greese |
    Then I should see no options for the lot
    When I enter the following details into the form:
      | Start typing to find a country  | |
    When I type the following details into the form:
      | Start typing to find a country  | Greece |
    Then I should see the following options for the lot:
      | Greece  |
    When I clear the form with backspaces:
      | Start typing to find a country  |
    Then I should see the following options for the lot:
      | Afghanistan                                  |
      | Albania                                      |
      | Algeria                                      |
      | American Samoa                               |
      | Andorra                                      |
      | Angola                                       |
      | Anguilla                                     |
      | Antarctica                                   |
      | Antigua and Barbuda                          |
      | Argentina                                    |
      | Armenia                                      |
      | Aruba                                        |
      | Australia                                    |
      | Austria                                      |
      | Azerbaijan                                   |
      | Bahrain                                      |
      | Bangladesh                                   |
      | Barbados                                     |
      | Belarus                                      |
      | Belize                                       |
      | Benin                                        |
      | Bermuda                                      |
      | Bhutan                                       |
      | Bolivia                                      |
      | Bonaire, Sint Eustatius and Saba             |
      | Bosnia and Herzegovina                       |
      | Botswana                                     |
      | Bouvet Island                                |
      | Brazil                                       |
      | British Indian Ocean Territory               |
      | British Virgin Islands                       |
      | Brunei                                       |
      | Bulgaria                                     |
      | Burkina Faso                                 |
      | Burundi                                      |
      | Cabo Verde                                   |
      | Cambodia                                     |
      | Cameroon                                     |
      | Cayman Islands                               |
      | Central African Republic                     |
      | Chad                                         |
      | Chile                                        |
      | China                                        |
      | Christmas Island                             |
      | Cocos (Keeling) Islands                      |
      | Colombia                                     |
      | Comoros                                      |
      | Congo                                        |
      | Congo (Democratic Republic)                  |
      | Cook Islands                                 |
      | Costa Rica                                   |
      | Croatia                                      |
      | Cuba                                         |
      | Curaçao                                      |
      | Cyprus                                       |
      | Czechia                                      |
      | Côte d'Ivoire                                |
      | Denmark                                      |
      | Djibouti                                     |
      | Dominica                                     |
      | Dominican Republic                           |
      | Ecuador                                      |
      | Egypt                                        |
      | El Salvador                                  |
      | Equatorial Guinea                            |
      | Eritrea                                      |
      | Estonia                                      |
      | Eswatini                                     |
      | Ethiopia                                     |
      | Falkland Islands                             |
      | Faroe Islands                                |
      | Federated States of Micronesia               |
      | Fiji                                         |
      | Finland                                      |
      | French Guiana                                |
      | French Polynesia                             |
      | French Southern Territories                  |
      | Gabon                                        |
      | Georgia                                      |
      | Ghana                                        |
      | Gibraltar                                    |
      | Greece                                       |
      | Greenland                                    |
      | Grenada                                      |
      | Guadeloupe                                   |
      | Guam                                         |
      | Guatemala                                    |
      | Guernsey                                     |
      | Guinea                                       |
      | Guinea-Bissau                                |
      | Guyana                                       |
      | Haiti                                        |
      | Heard Island and McDonald Islands            |
      | Honduras                                     |
      | Hong Kong                                    |
      | Hungary                                      |
      | Iceland                                      |
      | India                                        |
      | Indonesia                                    |
      | Iran                                         |
      | Iraq                                         |
      | Isle of Man                                  |
      | Israel                                       |
      | Italy                                        |
      | Jamaica                                      |
      | Japan                                        |
      | Jersey                                       |
      | Jordan                                       |
      | Kazakhstan                                   |
      | Kenya                                        |
      | Kiribati                                     |
      | Kuwait                                       |
      | Kyrgyzstan                                   |
      | Laos                                         |
      | Latvia                                       |
      | Lebanon                                      |
      | Lesotho                                      |
      | Liberia                                      |
      | Libya                                        |
      | Liechtenstein                                |
      | Lithuania                                    |
      | Luxembourg                                   |
      | Macao                                        |
      | Madagascar                                   |
      | Malawi                                       |
      | Malaysia                                     |
      | Maldives                                     |
      | Mali                                         |
      | Malta                                        |
      | Marshall Islands                             |
      | Martinique                                   |
      | Mauritania                                   |
      | Mauritius                                    |
      | Mayotte                                      |
      | Mexico                                       |
      | Moldova                                      |
      | Monaco                                       |
      | Mongolia                                     |
      | Montenegro                                   |
      | Montserrat                                   |
      | Morocco                                      |
      | Mozambique                                   |
      | Myanmar (Burma)                              |
      | Namibia                                      |
      | Nauru                                        |
      | Nepal                                        |
      | Netherlands                                  |
      | New Caledonia                                |
      | New Zealand                                  |
      | Nicaragua                                    |
      | Niger                                        |
      | Nigeria                                      |
      | Niue                                         |
      | Norfolk Island                               |
      | North Korea                                  |
      | North Macedonia                              |
      | Northern Mariana Islands                     |
      | Norway                                       |
      | Oman                                         |
      | Pakistan                                     |
      | Palau                                        |
      | Panama                                       |
      | Papua New Guinea                             |
      | Paraguay                                     |
      | Peru                                         |
      | Philippines                                  |
      | Pitcairn                                     |
      | Poland                                       |
      | Portugal                                     |
      | Puerto Rico                                  |
      | Qatar                                        |
      | Romania                                      |
      | Russia                                       |
      | Rwanda                                       |
      | Réunion                                      |
      | Samoa                                        |
      | San Marino                                   |
      | Sao Tome and Principe                        |
      | Saudi Arabia                                 |
      | Senegal                                      |
      | Serbia                                       |
      | Seychelles                                   |
      | Sierra Leone                                 |
      | Sint Maarten (Dutch part)                    |
      | Slovakia                                     |
      | Slovenia                                     |
      | Solomon Islands                              |
      | Somalia                                      |
      | South Africa                                 |
      | South Georgia and the South Sandwich Islands |
      | South Korea                                  |
      | South Sudan                                  |
      | Spain                                        |
      | Sri Lanka                                    |
      | St Barthélemy                                |
      | St Helena, Ascension and Tristan da Cunha    |
      | St Kitts and Nevis                           |
      | St Lucia                                     |
      | St Martin (French part)                      |
      | St Pierre and Miquelon                       |
      | St Vincent and the Grenadines                |
      | State of Palestine                           |
      | Sudan                                        |
      | Suriname                                     |
      | Svalbard and Jan Mayen                       |
      | Sweden                                       |
      | Syria                                        |
      | Taiwan                                       |
      | Tajikistan                                   |
      | Tanzania                                     |
      | Thailand                                     |
      | The Bahamas                                  |
      | The Gambia                                   |
      | Timor-Leste                                  |
      | Togo                                         |
      | Tokelau                                      |
      | Tonga                                        |
      | Trinidad and Tobago                          |
      | Tunisia                                      |
      | Turkey                                       |
      | Turkmenistan                                 |
      | Turks and Caicos Islands                     |
      | Tuvalu                                       |
      | Uganda                                       |
      | Ukraine                                      |
      | United Arab Emirates                         |
      | United States Minor Outlying Islands         |
      | United States Virgin Island                  |
      | Uruguay                                      |
      | Uzbekistan                                   |
      | Vanuatu                                      |
      | Vatican City                                 |
      | Venezuela                                    |
      | Vietnam                                      |
      | Wallis and Futuna                            |
      | Western Sahara                               |
      | Yemen                                        |
      | Zambia                                       |
      | Zimbabwe                                     |
      | Åland Islands                                |

  Scenario: Go back from services and change selection
    When I check the following items:
      | Gibraltar |
      | Greece    |
      | Greenland |
    And I click on 'Continue'
    Then I am on the 'Select the legal services you need' page
    And I click on the 'Back' back link
    Then I am on the 'Select the countires for your requirement' page
    And the following items should appear in the basket:
      | Gibraltar |
      | Greece    |
      | Greenland |
