Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4b - Jurisdictions

  Scenario: Jurisdictions
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOELPIN, HILLL AND COLLINS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And I click on 'View jurisdictions' for the lot 'Lot 4b - International Trade Disputes'
    Then I am on the 'Lot 4b - International Trade Disputes View jurisdictions' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And the supplier should be assigned to the 'jurisdictions' as follows:
      | Afghanistan                                  |
      | Albania                                      |
      | Algeria                                      |
      | American Samoa                               |
      | Angola                                       |
      | Antigua and Barbuda                          |
      | Argentina                                    |
      | Armenia                                      |
      | Austria                                      |
      | Azerbaijan                                   |
      | Bahrain                                      |
      | Barbados                                     |
      | Belarus                                      |
      | Belize                                       |
      | Bolivia                                      |
      | Bonaire, Sint Eustatius and Saba             |
      | Bosnia and Herzegovina                       |
      | Botswana                                     |
      | Bouvet Island                                |
      | Brunei                                       |
      | Bulgaria                                     |
      | Burkina Faso                                 |
      | Burundi                                      |
      | Cambodia                                     |
      | Cameroon                                     |
      | Cayman Islands                               |
      | Central African Republic                     |
      | Chad                                         |
      | Cocos (Keeling) Islands                      |
      | Comoros                                      |
      | Congo (Democratic Republic)                  |
      | Costa Rica                                   |
      | Cuba                                         |
      | Denmark                                      |
      | Dominica                                     |
      | Ecuador                                      |
      | Egypt                                        |
      | El Salvador                                  |
      | Estonia                                      |
      | Ethiopia                                     |
      | Falkland Islands                             |
      | Fiji                                         |
      | Finland                                      |
      | French Polynesia                             |
      | French Southern Territories                  |
      | Gabon                                        |
      | Georgia                                      |
      | Ghana                                        |
      | Grenada                                      |
      | Guadeloupe                                   |
      | Guam                                         |
      | Guinea                                       |
      | Guinea-Bissau                                |
      | Haiti                                        |
      | Hungary                                      |
      | Iceland                                      |
      | Iran                                         |
      | Iraq                                         |
      | Jersey                                       |
      | Kenya                                        |
      | Kuwait                                       |
      | Lebanon                                      |
      | Liberia                                      |
      | Macao                                        |
      | Malawi                                       |
      | Malaysia                                     |
      | Maldives                                     |
      | Mali                                         |
      | Martinique                                   |
      | Mauritius                                    |
      | Mayotte                                      |
      | Mexico                                       |
      | Montserrat                                   |
      | Morocco                                      |
      | Mozambique                                   |
      | Myanmar (Burma)                              |
      | Namibia                                      |
      | Nauru                                        |
      | New Zealand                                  |
      | Niger                                        |
      | Nigeria                                      |
      | Norfolk Island                               |
      | Northern Mariana Islands                     |
      | Pakistan                                     |
      | Palau                                        |
      | Panama                                       |
      | Paraguay                                     |
      | Puerto Rico                                  |
      | Rwanda                                       |
      | Réunion                                      |
      | San Marino                                   |
      | Saudi Arabia                                 |
      | Senegal                                      |
      | Serbia                                       |
      | Sint Maarten (Dutch part)                    |
      | Slovakia                                     |
      | Somalia                                      |
      | South Georgia and the South Sandwich Islands |
      | South Korea                                  |
      | South Sudan                                  |
      | St Barthélemy                                |
      | St Lucia                                     |
      | St Martin (French part)                      |
      | St Pierre and Miquelon                       |
      | St Vincent and the Grenadines                |
      | State of Palestine                           |
      | Syria                                        |
      | Tajikistan                                   |
      | The Bahamas                                  |
      | Tokelau                                      |
      | United Arab Emirates                         |
      | United States Virgin Island                  |
      | Uruguay                                      |
      | Vanuatu                                      |
      | Vietnam                                      |
      | Wallis and Futuna                            |
      | Yemen                                        |
      | Zambia                                       |
      | Zimbabwe                                     |
      | Åland Islands                                |
