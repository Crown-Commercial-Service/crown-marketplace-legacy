Feature: Legal Panel for Government - Admin - Supplier lot data - Lot 4a - Jurisdictions

  Scenario: Jurisdictions
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
