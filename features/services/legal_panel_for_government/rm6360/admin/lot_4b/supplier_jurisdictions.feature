Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4b - Jurisdictions

  Scenario: Jurisdictions
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOELPIN, HILLL AND COLLINS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And I click on 'View jurisdictions' for the lot 'Lot 4b - International Trade Disputes'
    Then I am on the 'Lot 4b - International Trade Disputes - Jurisdictions' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And the supplier should be assigned to the 'jurisdictions' as follows:
      | Jurisdiction                                 | Provides services in jurisdiction |
      | Afghanistan                                  | Yes                               |
      | Albania                                      | Yes                               |
      | Algeria                                      | Yes                               |
      | American Samoa                               | Yes                               |
      | Andorra                                      | No                                |
      | Angola                                       | Yes                               |
      | Anguilla                                     | No                                |
      | Antarctica                                   | No                                |
      | Antigua and Barbuda                          | Yes                               |
      | Argentina                                    | Yes                               |
      | Armenia                                      | Yes                               |
      | Aruba                                        | No                                |
      | Australia                                    | No                                |
      | Austria                                      | Yes                               |
      | Azerbaijan                                   | Yes                               |
      | Bahrain                                      | Yes                               |
      | Bangladesh                                   | No                                |
      | Barbados                                     | Yes                               |
      | Belarus                                      | Yes                               |
      | Belize                                       | Yes                               |
      | Benin                                        | No                                |
      | Bermuda                                      | No                                |
      | Bhutan                                       | No                                |
      | Bolivia                                      | Yes                               |
      | Bonaire, Sint Eustatius and Saba             | Yes                               |
      | Bosnia and Herzegovina                       | Yes                               |
      | Botswana                                     | Yes                               |
      | Bouvet Island                                | Yes                               |
      | Brazil                                       | No                                |
      | British Indian Ocean Territory               | No                                |
      | British Virgin Islands                       | No                                |
      | Brunei                                       | Yes                               |
      | Bulgaria                                     | Yes                               |
      | Burkina Faso                                 | Yes                               |
      | Burundi                                      | Yes                               |
      | Cabo Verde                                   | No                                |
      | Cambodia                                     | Yes                               |
      | Cameroon                                     | Yes                               |
      | Cayman Islands                               | Yes                               |
      | Central African Republic                     | Yes                               |
      | Chad                                         | Yes                               |
      | Chile                                        | No                                |
      | China                                        | No                                |
      | Christmas Island                             | No                                |
      | Cocos (Keeling) Islands                      | Yes                               |
      | Colombia                                     | No                                |
      | Comoros                                      | Yes                               |
      | Congo                                        | No                                |
      | Congo (Democratic Republic)                  | Yes                               |
      | Cook Islands                                 | No                                |
      | Costa Rica                                   | Yes                               |
      | Croatia                                      | No                                |
      | Cuba                                         | Yes                               |
      | Curaçao                                      | No                                |
      | Cyprus                                       | No                                |
      | Czechia                                      | No                                |
      | Côte d'Ivoire                                | No                                |
      | Denmark                                      | Yes                               |
      | Djibouti                                     | No                                |
      | Dominica                                     | Yes                               |
      | Dominican Republic                           | No                                |
      | Ecuador                                      | Yes                               |
      | Egypt                                        | Yes                               |
      | El Salvador                                  | Yes                               |
      | Equatorial Guinea                            | No                                |
      | Eritrea                                      | No                                |
      | Estonia                                      | Yes                               |
      | Eswatini                                     | No                                |
      | Ethiopia                                     | Yes                               |
      | Falkland Islands                             | Yes                               |
      | Faroe Islands                                | No                                |
      | Federated States of Micronesia               | No                                |
      | Fiji                                         | Yes                               |
      | Finland                                      | Yes                               |
      | French Guiana                                | No                                |
      | French Polynesia                             | Yes                               |
      | French Southern Territories                  | Yes                               |
      | Gabon                                        | Yes                               |
      | Georgia                                      | Yes                               |
      | Ghana                                        | Yes                               |
      | Gibraltar                                    | No                                |
      | Greece                                       | No                                |
      | Greenland                                    | No                                |
      | Grenada                                      | Yes                               |
      | Guadeloupe                                   | Yes                               |
      | Guam                                         | Yes                               |
      | Guatemala                                    | No                                |
      | Guernsey                                     | No                                |
      | Guinea                                       | Yes                               |
      | Guinea-Bissau                                | Yes                               |
      | Guyana                                       | No                                |
      | Haiti                                        | Yes                               |
      | Heard Island and McDonald Islands            | No                                |
      | Honduras                                     | No                                |
      | Hong Kong                                    | No                                |
      | Hungary                                      | Yes                               |
      | Iceland                                      | Yes                               |
      | India                                        | No                                |
      | Indonesia                                    | No                                |
      | Iran                                         | Yes                               |
      | Iraq                                         | Yes                               |
      | Isle of Man                                  | No                                |
      | Israel                                       | No                                |
      | Italy                                        | No                                |
      | Jamaica                                      | No                                |
      | Japan                                        | No                                |
      | Jersey                                       | Yes                               |
      | Jordan                                       | No                                |
      | Kazakhstan                                   | No                                |
      | Kenya                                        | Yes                               |
      | Kiribati                                     | No                                |
      | Kuwait                                       | Yes                               |
      | Kyrgyzstan                                   | No                                |
      | Laos                                         | No                                |
      | Latvia                                       | No                                |
      | Lebanon                                      | Yes                               |
      | Lesotho                                      | No                                |
      | Liberia                                      | Yes                               |
      | Libya                                        | No                                |
      | Liechtenstein                                | No                                |
      | Lithuania                                    | No                                |
      | Luxembourg                                   | No                                |
      | Macao                                        | Yes                               |
      | Madagascar                                   | No                                |
      | Malawi                                       | Yes                               |
      | Malaysia                                     | Yes                               |
      | Maldives                                     | Yes                               |
      | Mali                                         | Yes                               |
      | Malta                                        | No                                |
      | Marshall Islands                             | No                                |
      | Martinique                                   | Yes                               |
      | Mauritania                                   | No                                |
      | Mauritius                                    | Yes                               |
      | Mayotte                                      | Yes                               |
      | Mexico                                       | Yes                               |
      | Moldova                                      | No                                |
      | Monaco                                       | No                                |
      | Mongolia                                     | No                                |
      | Montenegro                                   | No                                |
      | Montserrat                                   | Yes                               |
      | Morocco                                      | Yes                               |
      | Mozambique                                   | Yes                               |
      | Myanmar (Burma)                              | Yes                               |
      | Namibia                                      | Yes                               |
      | Nauru                                        | Yes                               |
      | Nepal                                        | No                                |
      | Netherlands                                  | No                                |
      | New Caledonia                                | No                                |
      | New Zealand                                  | Yes                               |
      | Nicaragua                                    | No                                |
      | Niger                                        | Yes                               |
      | Nigeria                                      | Yes                               |
      | Niue                                         | No                                |
      | Norfolk Island                               | Yes                               |
      | North Korea                                  | No                                |
      | North Macedonia                              | No                                |
      | Northern Mariana Islands                     | Yes                               |
      | Norway                                       | No                                |
      | Oman                                         | No                                |
      | Pakistan                                     | Yes                               |
      | Palau                                        | Yes                               |
      | Panama                                       | Yes                               |
      | Papua New Guinea                             | No                                |
      | Paraguay                                     | Yes                               |
      | Peru                                         | No                                |
      | Philippines                                  | No                                |
      | Pitcairn                                     | No                                |
      | Poland                                       | No                                |
      | Portugal                                     | No                                |
      | Puerto Rico                                  | Yes                               |
      | Qatar                                        | No                                |
      | Romania                                      | No                                |
      | Russia                                       | No                                |
      | Rwanda                                       | Yes                               |
      | Réunion                                      | Yes                               |
      | Samoa                                        | No                                |
      | San Marino                                   | Yes                               |
      | Sao Tome and Principe                        | No                                |
      | Saudi Arabia                                 | Yes                               |
      | Senegal                                      | Yes                               |
      | Serbia                                       | Yes                               |
      | Seychelles                                   | No                                |
      | Sierra Leone                                 | No                                |
      | Sint Maarten (Dutch part)                    | Yes                               |
      | Slovakia                                     | Yes                               |
      | Slovenia                                     | No                                |
      | Solomon Islands                              | No                                |
      | Somalia                                      | Yes                               |
      | South Africa                                 | No                                |
      | South Georgia and the South Sandwich Islands | Yes                               |
      | South Korea                                  | Yes                               |
      | South Sudan                                  | Yes                               |
      | Spain                                        | No                                |
      | Sri Lanka                                    | No                                |
      | St Barthélemy                                | Yes                               |
      | St Helena, Ascension and Tristan da Cunha    | No                                |
      | St Kitts and Nevis                           | No                                |
      | St Lucia                                     | Yes                               |
      | St Martin (French part)                      | Yes                               |
      | St Pierre and Miquelon                       | Yes                               |
      | St Vincent and the Grenadines                | Yes                               |
      | State of Palestine                           | Yes                               |
      | Sudan                                        | No                                |
      | Suriname                                     | No                                |
      | Svalbard and Jan Mayen                       | No                                |
      | Sweden                                       | No                                |
      | Syria                                        | Yes                               |
      | Taiwan                                       | No                                |
      | Tajikistan                                   | Yes                               |
      | Tanzania                                     | No                                |
      | Thailand                                     | No                                |
      | The Bahamas                                  | Yes                               |
      | The Gambia                                   | No                                |
      | Timor-Leste                                  | No                                |
      | Togo                                         | No                                |
      | Tokelau                                      | Yes                               |
      | Tonga                                        | No                                |
      | Trinidad and Tobago                          | No                                |
      | Tunisia                                      | No                                |
      | Turkey                                       | No                                |
      | Turkmenistan                                 | No                                |
      | Turks and Caicos Islands                     | No                                |
      | Tuvalu                                       | No                                |
      | Uganda                                       | No                                |
      | Ukraine                                      | No                                |
      | United Arab Emirates                         | Yes                               |
      | United States Minor Outlying Islands         | No                                |
      | United States Virgin Island                  | Yes                               |
      | Uruguay                                      | Yes                               |
      | Uzbekistan                                   | No                                |
      | Vanuatu                                      | Yes                               |
      | Vatican City                                 | No                                |
      | Venezuela                                    | No                                |
      | Vietnam                                      | Yes                               |
      | Wallis and Futuna                            | Yes                               |
      | Western Sahara                               | No                                |
      | Yemen                                        | Yes                               |
      | Zambia                                       | Yes                               |
      | Zimbabwe                                     | Yes                               |
      | Åland Islands                                | Yes                               |
