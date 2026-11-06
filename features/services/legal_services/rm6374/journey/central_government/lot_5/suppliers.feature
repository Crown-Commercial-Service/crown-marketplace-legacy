Feature: Legal services -  Central governemnt - Lot 5 - Suppliers

  Background: Navigate to start page and complete the journey
    Given I sign in and navigate to the start page for the 'RM6374' framework in 'legal services'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes' for 'requirement replace an existing contract'
    And I select 'Likely' for 'requirement being awarded'
    And I select 'Yes' for 'CCS contact you'
    And I click on 'Continue'
    Then I am on the 'Please select your customer sector' page
    And I select 'Health' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Legal services requiring a deep understanding of the transport, rail, highways, maritime, ports aviation and planning industry' for 'requirements'
    And I click on 'Continue'
    Then I am on the 'Select the legal specialism(s) you require' page
    When I check the following items:
      | Competition Law        |
      | Employment Law         |
      | Highways Law           |
      | Maritime and Shipping  |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 5 - Transport and Rail'
    And I select 'Scotland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | RODRIGUEZ GROUP                        | http://rodriguezgroup.test/ashleigh                |
      | DONNELLY, DICKINSON AND ABBOTT         | http://donnellydickinsonandabbott.test/mickey.borer|
      | BROWN, JOHNSTON AND SHANAHAN           | http://brownjohnstonandshanahan.test/tula          |
      | SCHNEIDER-BRUEN SME                    | http://schneider-bruen.example/morton_turcotte     |
      | SENGER, MUELLER AND WIEGAND SME        | http://sengermuellerandwiegand.example/elma.dach   |
      | LEMKE, JOHNS AND KUTCH                 | http://lemkejohnsandkutch.example/ellsworth        |
      | STROMAN, NOLAN AND LOCKMAN             | http://stromannolanandlockman.test/brenton_schuppe |
      | SCHNEIDER, ARMSTRONG AND ABERNATHY SME | http://schneiderarmstrongandabernathy.test/elvera  |
  Scenario: Check the supplier data - SME
    Given I click on 'SCHNEIDER-BRUEN'
    Then I am on the 'SCHNEIDER-BRUEN' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£315.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£245.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£210.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£175.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£140.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£105.00'
    And the contact details for the supplier are:
      | bruen_schneider@hamill.example                     |
      | 525-738-4613                                       |
      | http://schneider-bruen.example/jenniffer           |
      | Suite 165 6276 Rippin Mount, Eliseoville, TX 47425 |
