Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4a - Jurisdictions

  Scenario: Jurisdictions
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'DICKI, QUITZON AND KUB'
    Then I am on the 'Supplier lot data' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And I click on 'View jurisdictions' for the lot 'Lot 4a - Trade and Investment Negotiations'
    Then I am on the 'Lot 4a - Trade and Investment Negotiations - Jurisdictions' page
    And the caption is 'DICKI, QUITZON AND KUB'
    And the supplier should be assigned to the 'jurisdictions' as follows:
      | Jurisdiction                                 | Provides services in jurisdiction? |
      | Afghanistan                                  | No                                 |
      | Albania                                      | No                                 |
      | Algeria                                      | Yes                                |
      | American Samoa                               | Yes                                |
      | Andorra                                      | No                                 |
      | Angola                                       | Yes                                |
      | Anguilla                                     | Yes                                |
      | Antarctica                                   | Yes                                |
      | Antigua and Barbuda                          | No                                 |
      | Argentina                                    | No                                 |
      | Armenia                                      | No                                 |
      | Aruba                                        | No                                 |
      | Australia                                    | Yes                                |
      | Austria                                      | No                                 |
      | Azerbaijan                                   | No                                 |
      | Bahrain                                      | No                                 |
      | Bangladesh                                   | Yes                                |
      | Barbados                                     | No                                 |
      | Belarus                                      | Yes                                |
      | Belize                                       | No                                 |
      | Benin                                        | Yes                                |
      | Bermuda                                      | No                                 |
      | Bhutan                                       | No                                 |
      | Bolivia                                      | No                                 |
      | Bonaire, Sint Eustatius and Saba             | No                                 |
      | Bosnia and Herzegovina                       | No                                 |
      | Botswana                                     | No                                 |
      | Bouvet Island                                | Yes                                |
      | Brazil                                       | No                                 |
      | British Indian Ocean Territory               | No                                 |
      | British Virgin Islands                       | Yes                                |
      | Brunei                                       | Yes                                |
      | Bulgaria                                     | No                                 |
      | Burkina Faso                                 | No                                 |
      | Burundi                                      | No                                 |
      | Cabo Verde                                   | Yes                                |
      | Cambodia                                     | Yes                                |
      | Cameroon                                     | No                                 |
      | Cayman Islands                               | No                                 |
      | Central African Republic                     | No                                 |
      | Chad                                         | No                                 |
      | Chile                                        | No                                 |
      | China                                        | Yes                                |
      | Christmas Island                             | Yes                                |
      | Cocos (Keeling) Islands                      | Yes                                |
      | Colombia                                     | No                                 |
      | Comoros                                      | No                                 |
      | Congo                                        | No                                 |
      | Congo (Democratic Republic)                  | No                                 |
      | Cook Islands                                 | Yes                                |
      | Costa Rica                                   | No                                 |
      | Croatia                                      | Yes                                |
      | Cuba                                         | Yes                                |
      | Curaçao                                      | Yes                                |
      | Cyprus                                       | No                                 |
      | Czechia                                      | Yes                                |
      | Côte d'Ivoire                                | No                                 |
      | Denmark                                      | No                                 |
      | Djibouti                                     | No                                 |
      | Dominica                                     | No                                 |
      | Dominican Republic                           | Yes                                |
      | Ecuador                                      | No                                 |
      | Egypt                                        | No                                 |
      | El Salvador                                  | No                                 |
      | Equatorial Guinea                            | Yes                                |
      | Eritrea                                      | No                                 |
      | Estonia                                      | Yes                                |
      | Eswatini                                     | No                                 |
      | Ethiopia                                     | Yes                                |
      | Falkland Islands                             | No                                 |
      | Faroe Islands                                | Yes                                |
      | Federated States of Micronesia               | No                                 |
      | Fiji                                         | No                                 |
      | Finland                                      | Yes                                |
      | French Guiana                                | No                                 |
      | French Polynesia                             | No                                 |
      | French Southern Territories                  | No                                 |
      | Gabon                                        | Yes                                |
      | Georgia                                      | No                                 |
      | Ghana                                        | No                                 |
      | Gibraltar                                    | No                                 |
      | Greece                                       | No                                 |
      | Greenland                                    | No                                 |
      | Grenada                                      | No                                 |
      | Guadeloupe                                   | No                                 |
      | Guam                                         | No                                 |
      | Guatemala                                    | No                                 |
      | Guernsey                                     | No                                 |
      | Guinea                                       | Yes                                |
      | Guinea-Bissau                                | Yes                                |
      | Guyana                                       | Yes                                |
      | Haiti                                        | No                                 |
      | Heard Island and McDonald Islands            | No                                 |
      | Honduras                                     | Yes                                |
      | Hong Kong                                    | No                                 |
      | Hungary                                      | No                                 |
      | Iceland                                      | Yes                                |
      | India                                        | No                                 |
      | Indonesia                                    | Yes                                |
      | Iran                                         | No                                 |
      | Iraq                                         | Yes                                |
      | Isle of Man                                  | Yes                                |
      | Israel                                       | Yes                                |
      | Italy                                        | No                                 |
      | Jamaica                                      | No                                 |
      | Japan                                        | No                                 |
      | Jersey                                       | Yes                                |
      | Jordan                                       | No                                 |
      | Kazakhstan                                   | No                                 |
      | Kenya                                        | No                                 |
      | Kiribati                                     | Yes                                |
      | Kuwait                                       | No                                 |
      | Kyrgyzstan                                   | Yes                                |
      | Laos                                         | No                                 |
      | Latvia                                       | Yes                                |
      | Lebanon                                      | Yes                                |
      | Lesotho                                      | No                                 |
      | Liberia                                      | No                                 |
      | Libya                                        | No                                 |
      | Liechtenstein                                | Yes                                |
      | Lithuania                                    | No                                 |
      | Luxembourg                                   | Yes                                |
      | Macao                                        | No                                 |
      | Madagascar                                   | Yes                                |
      | Malawi                                       | No                                 |
      | Malaysia                                     | No                                 |
      | Maldives                                     | Yes                                |
      | Mali                                         | Yes                                |
      | Malta                                        | No                                 |
      | Marshall Islands                             | Yes                                |
      | Martinique                                   | No                                 |
      | Mauritania                                   | Yes                                |
      | Mauritius                                    | No                                 |
      | Mayotte                                      | No                                 |
      | Mexico                                       | No                                 |
      | Moldova                                      | Yes                                |
      | Monaco                                       | No                                 |
      | Mongolia                                     | No                                 |
      | Montenegro                                   | Yes                                |
      | Montserrat                                   | No                                 |
      | Morocco                                      | Yes                                |
      | Mozambique                                   | No                                 |
      | Myanmar (Burma)                              | No                                 |
      | Namibia                                      | Yes                                |
      | Nauru                                        | Yes                                |
      | Nepal                                        | Yes                                |
      | Netherlands                                  | No                                 |
      | New Caledonia                                | No                                 |
      | New Zealand                                  | No                                 |
      | Nicaragua                                    | Yes                                |
      | Niger                                        | No                                 |
      | Nigeria                                      | No                                 |
      | Niue                                         | No                                 |
      | Norfolk Island                               | No                                 |
      | North Korea                                  | Yes                                |
      | North Macedonia                              | No                                 |
      | Northern Mariana Islands                     | Yes                                |
      | Norway                                       | No                                 |
      | Oman                                         | No                                 |
      | Pakistan                                     | No                                 |
      | Palau                                        | No                                 |
      | Panama                                       | Yes                                |
      | Papua New Guinea                             | No                                 |
      | Paraguay                                     | Yes                                |
      | Peru                                         | Yes                                |
      | Philippines                                  | No                                 |
      | Pitcairn                                     | No                                 |
      | Poland                                       | No                                 |
      | Portugal                                     | No                                 |
      | Puerto Rico                                  | Yes                                |
      | Qatar                                        | No                                 |
      | Romania                                      | Yes                                |
      | Russia                                       | No                                 |
      | Rwanda                                       | No                                 |
      | Réunion                                      | No                                 |
      | Samoa                                        | No                                 |
      | San Marino                                   | No                                 |
      | Sao Tome and Principe                        | No                                 |
      | Saudi Arabia                                 | No                                 |
      | Senegal                                      | No                                 |
      | Serbia                                       | Yes                                |
      | Seychelles                                   | No                                 |
      | Sierra Leone                                 | No                                 |
      | Sint Maarten (Dutch part)                    | Yes                                |
      | Slovakia                                     | No                                 |
      | Slovenia                                     | No                                 |
      | Solomon Islands                              | Yes                                |
      | Somalia                                      | No                                 |
      | South Africa                                 | No                                 |
      | South Georgia and the South Sandwich Islands | No                                 |
      | South Korea                                  | Yes                                |
      | South Sudan                                  | Yes                                |
      | Spain                                        | No                                 |
      | Sri Lanka                                    | Yes                                |
      | St Barthélemy                                | Yes                                |
      | St Helena, Ascension and Tristan da Cunha    | Yes                                |
      | St Kitts and Nevis                           | Yes                                |
      | St Lucia                                     | Yes                                |
      | St Martin (French part)                      | No                                 |
      | St Pierre and Miquelon                       | Yes                                |
      | St Vincent and the Grenadines                | No                                 |
      | State of Palestine                           | Yes                                |
      | Sudan                                        | No                                 |
      | Suriname                                     | No                                 |
      | Svalbard and Jan Mayen                       | Yes                                |
      | Sweden                                       | No                                 |
      | Syria                                        | No                                 |
      | Taiwan                                       | Yes                                |
      | Tajikistan                                   | No                                 |
      | Tanzania                                     | Yes                                |
      | Thailand                                     | No                                 |
      | The Bahamas                                  | No                                 |
      | The Gambia                                   | No                                 |
      | Timor-Leste                                  | No                                 |
      | Togo                                         | No                                 |
      | Tokelau                                      | No                                 |
      | Tonga                                        | No                                 |
      | Trinidad and Tobago                          | Yes                                |
      | Tunisia                                      | No                                 |
      | Turkey                                       | No                                 |
      | Turkmenistan                                 | No                                 |
      | Turks and Caicos Islands                     | Yes                                |
      | Tuvalu                                       | No                                 |
      | Uganda                                       | Yes                                |
      | Ukraine                                      | No                                 |
      | United Arab Emirates                         | Yes                                |
      | United States Minor Outlying Islands         | No                                 |
      | United States Virgin Island                  | No                                 |
      | Uruguay                                      | No                                 |
      | Uzbekistan                                   | No                                 |
      | Vanuatu                                      | Yes                                |
      | Vatican City                                 | No                                 |
      | Venezuela                                    | Yes                                |
      | Vietnam                                      | Yes                                |
      | Wallis and Futuna                            | Yes                                |
      | Western Sahara                               | Yes                                |
      | Yemen                                        | No                                 |
      | Zambia                                       | Yes                                |
      | Zimbabwe                                     | No                                 |
      | Åland Islands                                | No                                 |
