Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4c - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'View supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'VEUM, TORPHY AND NOLAN'
    Then I am on the 'Supplier lot data' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I click on 'View rates' for the lot 'Lot 4c - International Investment Disputes'
    Then I am on the 'Lot 4c - International Investment Disputes - Rates' page
    And the caption is 'VEUM, TORPHY AND NOLAN'
    And I should see rate tables for the following jurisdictions:
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
      | United Kingdom                               |
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
    And the rates in the 'Estonia' table are:
      | Position                                                           | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £270.00 |
      | Partner                                                            | £240.00 |
      | Legal Director/Counsel or equivalent                               | £210.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £180.00 |
      | Solicitor, Associate/Legal Executive                               | £150.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £120.00 |
      | Trainee/Legal Apprentice                                           | £72.00  |
      | Paralegal, Legal Assistant                                         | £60.00  |
      | Senior Analyst                                                     | £150.00 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £120.00 |
      | Senior Modeller, Senior Econometrician, Senior Analyst             | £180.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £150.00 |
    And the rates in the 'Sweden' table are:
      | Position                                                           | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £315.00 |
      | Partner                                                            | £280.00 |
      | Legal Director/Counsel or equivalent                               | £245.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £210.00 |
      | Solicitor, Associate/Legal Executive                               | £175.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £140.00 |
      | Trainee/Legal Apprentice                                           | £84.00  |
      | Paralegal, Legal Assistant                                         | £70.00  |
      | Senior Analyst                                                     | £175.00 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £140.00 |
      | Senior Modeller, Senior Econometrician, Senior Analyst             | £210.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £175.00 |
    And the rates in the 'United Kingdom' table are:
      | Position                                                           | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £270.00 |
      | Partner                                                            | £240.00 |
      | Legal Director/Counsel or equivalent                               | £210.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £180.00 |
      | Solicitor, Associate/Legal Executive                               | £150.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £120.00 |
      | Trainee/Legal Apprentice                                           | £72.00  |
      | Paralegal, Legal Assistant                                         | £60.00  |
      | Senior Analyst                                                     | £150.00 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £120.00 |
      | Senior Modeller, Senior Econometrician, Senior Analyst             | £180.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £150.00 |
