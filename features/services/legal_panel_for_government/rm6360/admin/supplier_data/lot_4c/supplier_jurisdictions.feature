Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4c - Jurisdictions

  Scenario: Jurisdictions
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I click on 'View jurisdictions' for the lot 'Lot 4c - International Investment Disputes'
    Then I am on the 'Lot 4c - International Investment Disputes - Jurisdictions' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And the supplier should be assigned to the 'jurisdictions' as follows:
      | Jurisdiction                                 | Provides services in jurisdiction? |
      | Afghanistan                                  | Yes                                |
      | Albania                                      | Yes                                |
      | Algeria                                      | Yes                                |
      | American Samoa                               | Yes                                |
      | Andorra                                      | Yes                                |
      | Angola                                       | Yes                                |
      | Anguilla                                     | Yes                                |
      | Antarctica                                   | Yes                                |
      | Antigua and Barbuda                          | Yes                                |
      | Argentina                                    | Yes                                |
      | Armenia                                      | Yes                                |
      | Aruba                                        | Yes                                |
      | Australia                                    | Yes                                |
      | Austria                                      | Yes                                |
      | Azerbaijan                                   | Yes                                |
      | Bahrain                                      | Yes                                |
      | Bangladesh                                   | Yes                                |
      | Barbados                                     | Yes                                |
      | Belarus                                      | Yes                                |
      | Belize                                       | Yes                                |
      | Benin                                        | Yes                                |
      | Bermuda                                      | Yes                                |
      | Bhutan                                       | Yes                                |
      | Bolivia                                      | Yes                                |
      | Bonaire, Sint Eustatius and Saba             | Yes                                |
      | Bosnia and Herzegovina                       | Yes                                |
      | Botswana                                     | Yes                                |
      | Bouvet Island                                | Yes                                |
      | Brazil                                       | Yes                                |
      | British Indian Ocean Territory               | Yes                                |
      | British Virgin Islands                       | Yes                                |
      | Brunei                                       | Yes                                |
      | Bulgaria                                     | Yes                                |
      | Burkina Faso                                 | Yes                                |
      | Burundi                                      | Yes                                |
      | Cabo Verde                                   | Yes                                |
      | Cambodia                                     | Yes                                |
      | Cameroon                                     | Yes                                |
      | Cayman Islands                               | Yes                                |
      | Central African Republic                     | Yes                                |
      | Chad                                         | Yes                                |
      | Chile                                        | Yes                                |
      | China                                        | Yes                                |
      | Christmas Island                             | Yes                                |
      | Cocos (Keeling) Islands                      | Yes                                |
      | Colombia                                     | Yes                                |
      | Comoros                                      | Yes                                |
      | Congo                                        | Yes                                |
      | Congo (Democratic Republic)                  | Yes                                |
      | Cook Islands                                 | Yes                                |
      | Costa Rica                                   | Yes                                |
      | Croatia                                      | Yes                                |
      | Cuba                                         | Yes                                |
      | Curaçao                                      | Yes                                |
      | Cyprus                                       | Yes                                |
      | Czechia                                      | Yes                                |
      | Côte d'Ivoire                                | Yes                                |
      | Denmark                                      | Yes                                |
      | Djibouti                                     | Yes                                |
      | Dominica                                     | Yes                                |
      | Dominican Republic                           | Yes                                |
      | Ecuador                                      | Yes                                |
      | Egypt                                        | Yes                                |
      | El Salvador                                  | Yes                                |
      | Equatorial Guinea                            | Yes                                |
      | Eritrea                                      | Yes                                |
      | Estonia                                      | Yes                                |
      | Eswatini                                     | Yes                                |
      | Ethiopia                                     | Yes                                |
      | Falkland Islands                             | Yes                                |
      | Faroe Islands                                | Yes                                |
      | Federated States of Micronesia               | Yes                                |
      | Fiji                                         | Yes                                |
      | Finland                                      | Yes                                |
      | French Guiana                                | Yes                                |
      | French Polynesia                             | Yes                                |
      | French Southern Territories                  | Yes                                |
      | Gabon                                        | Yes                                |
      | Georgia                                      | Yes                                |
      | Ghana                                        | Yes                                |
      | Gibraltar                                    | Yes                                |
      | Greece                                       | Yes                                |
      | Greenland                                    | Yes                                |
      | Grenada                                      | Yes                                |
      | Guadeloupe                                   | Yes                                |
      | Guam                                         | Yes                                |
      | Guatemala                                    | Yes                                |
      | Guernsey                                     | Yes                                |
      | Guinea                                       | Yes                                |
      | Guinea-Bissau                                | Yes                                |
      | Guyana                                       | Yes                                |
      | Haiti                                        | Yes                                |
      | Heard Island and McDonald Islands            | Yes                                |
      | Honduras                                     | Yes                                |
      | Hong Kong                                    | Yes                                |
      | Hungary                                      | Yes                                |
      | Iceland                                      | Yes                                |
      | India                                        | Yes                                |
      | Indonesia                                    | Yes                                |
      | Iran                                         | Yes                                |
      | Iraq                                         | Yes                                |
      | Isle of Man                                  | Yes                                |
      | Israel                                       | Yes                                |
      | Italy                                        | Yes                                |
      | Jamaica                                      | Yes                                |
      | Japan                                        | Yes                                |
      | Jersey                                       | Yes                                |
      | Jordan                                       | Yes                                |
      | Kazakhstan                                   | Yes                                |
      | Kenya                                        | Yes                                |
      | Kiribati                                     | Yes                                |
      | Kuwait                                       | Yes                                |
      | Kyrgyzstan                                   | Yes                                |
      | Laos                                         | Yes                                |
      | Latvia                                       | Yes                                |
      | Lebanon                                      | Yes                                |
      | Lesotho                                      | Yes                                |
      | Liberia                                      | Yes                                |
      | Libya                                        | Yes                                |
      | Liechtenstein                                | Yes                                |
      | Lithuania                                    | Yes                                |
      | Luxembourg                                   | Yes                                |
      | Macao                                        | Yes                                |
      | Madagascar                                   | Yes                                |
      | Malawi                                       | Yes                                |
      | Malaysia                                     | Yes                                |
      | Maldives                                     | Yes                                |
      | Mali                                         | Yes                                |
      | Malta                                        | Yes                                |
      | Marshall Islands                             | Yes                                |
      | Martinique                                   | Yes                                |
      | Mauritania                                   | Yes                                |
      | Mauritius                                    | Yes                                |
      | Mayotte                                      | Yes                                |
      | Mexico                                       | Yes                                |
      | Moldova                                      | Yes                                |
      | Monaco                                       | Yes                                |
      | Mongolia                                     | Yes                                |
      | Montenegro                                   | Yes                                |
      | Montserrat                                   | Yes                                |
      | Morocco                                      | Yes                                |
      | Mozambique                                   | Yes                                |
      | Myanmar (Burma)                              | Yes                                |
      | Namibia                                      | Yes                                |
      | Nauru                                        | Yes                                |
      | Nepal                                        | Yes                                |
      | Netherlands                                  | Yes                                |
      | New Caledonia                                | Yes                                |
      | New Zealand                                  | Yes                                |
      | Nicaragua                                    | Yes                                |
      | Niger                                        | Yes                                |
      | Nigeria                                      | Yes                                |
      | Niue                                         | Yes                                |
      | Norfolk Island                               | Yes                                |
      | North Korea                                  | Yes                                |
      | North Macedonia                              | Yes                                |
      | Northern Mariana Islands                     | Yes                                |
      | Norway                                       | Yes                                |
      | Oman                                         | Yes                                |
      | Pakistan                                     | Yes                                |
      | Palau                                        | Yes                                |
      | Panama                                       | Yes                                |
      | Papua New Guinea                             | Yes                                |
      | Paraguay                                     | Yes                                |
      | Peru                                         | Yes                                |
      | Philippines                                  | Yes                                |
      | Pitcairn                                     | Yes                                |
      | Poland                                       | Yes                                |
      | Portugal                                     | Yes                                |
      | Puerto Rico                                  | Yes                                |
      | Qatar                                        | Yes                                |
      | Romania                                      | Yes                                |
      | Russia                                       | Yes                                |
      | Rwanda                                       | Yes                                |
      | Réunion                                      | Yes                                |
      | Samoa                                        | Yes                                |
      | San Marino                                   | Yes                                |
      | Sao Tome and Principe                        | Yes                                |
      | Saudi Arabia                                 | Yes                                |
      | Senegal                                      | Yes                                |
      | Serbia                                       | Yes                                |
      | Seychelles                                   | Yes                                |
      | Sierra Leone                                 | Yes                                |
      | Sint Maarten (Dutch part)                    | Yes                                |
      | Slovakia                                     | Yes                                |
      | Slovenia                                     | Yes                                |
      | Solomon Islands                              | Yes                                |
      | Somalia                                      | Yes                                |
      | South Africa                                 | Yes                                |
      | South Georgia and the South Sandwich Islands | Yes                                |
      | South Korea                                  | Yes                                |
      | South Sudan                                  | Yes                                |
      | Spain                                        | Yes                                |
      | Sri Lanka                                    | Yes                                |
      | St Barthélemy                                | Yes                                |
      | St Helena, Ascension and Tristan da Cunha    | Yes                                |
      | St Kitts and Nevis                           | Yes                                |
      | St Lucia                                     | Yes                                |
      | St Martin (French part)                      | Yes                                |
      | St Pierre and Miquelon                       | Yes                                |
      | St Vincent and the Grenadines                | Yes                                |
      | State of Palestine                           | Yes                                |
      | Sudan                                        | Yes                                |
      | Suriname                                     | Yes                                |
      | Svalbard and Jan Mayen                       | Yes                                |
      | Sweden                                       | Yes                                |
      | Syria                                        | Yes                                |
      | Taiwan                                       | Yes                                |
      | Tajikistan                                   | Yes                                |
      | Tanzania                                     | Yes                                |
      | Thailand                                     | Yes                                |
      | The Bahamas                                  | Yes                                |
      | The Gambia                                   | Yes                                |
      | Timor-Leste                                  | Yes                                |
      | Togo                                         | Yes                                |
      | Tokelau                                      | Yes                                |
      | Tonga                                        | Yes                                |
      | Trinidad and Tobago                          | Yes                                |
      | Tunisia                                      | Yes                                |
      | Turkey                                       | Yes                                |
      | Turkmenistan                                 | Yes                                |
      | Turks and Caicos Islands                     | Yes                                |
      | Tuvalu                                       | Yes                                |
      | Uganda                                       | Yes                                |
      | Ukraine                                      | Yes                                |
      | United Arab Emirates                         | Yes                                |
      | United States Minor Outlying Islands         | Yes                                |
      | United States Virgin Island                  | Yes                                |
      | Uruguay                                      | Yes                                |
      | Uzbekistan                                   | Yes                                |
      | Vanuatu                                      | Yes                                |
      | Vatican City                                 | Yes                                |
      | Venezuela                                    | Yes                                |
      | Vietnam                                      | Yes                                |
      | Wallis and Futuna                            | Yes                                |
      | Western Sahara                               | Yes                                |
      | Yemen                                        | Yes                                |
      | Zambia                                       | Yes                                |
      | Zimbabwe                                     | Yes                                |
      | Åland Islands                                | Yes                                |
