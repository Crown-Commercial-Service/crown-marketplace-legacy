Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4b - Rates

  Scenario: Rates
    Given I sign in as an admin for the 'RM6360' framework in 'legal panel for government'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View lot data' for 'KOELPIN, HILLL AND COLLINS'
    Then I am on the 'Supplier lot data' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And I click on 'View rates' for the lot 'Lot 4b - International Trade Disputes'
    Then I am on the 'Lot 4b - International Trade Disputes - Rates' page
    And the caption is 'KOELPIN, HILLL AND COLLINS'
    And I should see rate tables for the following jurisdictions:
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
      | United Kingdom                               |
      | United States Virgin Island                  |
      | Uruguay                                      |
      | Vanuatu                                      |
      | Vietnam                                      |
      | Wallis and Futuna                            |
      | Yemen                                        |
      | Zambia                                       |
      | Zimbabwe                                     |
      | Åland Islands                                |
    And the rates in the 'Burundi' table are:
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
      | Modeller, Econometrician, Analyst, Associate Analyst               | £175.00 |
    And the rates in the 'Mexico' table are:
      | Position                                                           | Hourly  |
      | Senior Counsel, Senior Partner (20 years +PQE)                     | £225.00 |
      | Partner                                                            | £200.00 |
      | Legal Director/Counsel or equivalent                               | £175.00 |
      | Senior Solicitor, Senior Associate/Senior Legal Executive          | £150.00 |
      | Solicitor, Associate/Legal Executive                               | £125.00 |
      | NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive | £100.00 |
      | Trainee/Legal Apprentice                                           | £60.00  |
      | Paralegal, Legal Assistant                                         | £50.00  |
      | Senior Analyst                                                     | £125.00 |
      | Analyst, Associate Analyst, Research Associate, Research Officer   | £100.00 |
      | Modeller, Econometrician, Analyst, Associate Analyst               | £125.00 |
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
      | Modeller, Econometrician, Analyst, Associate Analyst               | £150.00 |
