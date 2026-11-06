Feature: Legal services -  Central government - Lot 4 - Suppliers

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
    And I select 'Legal services for a project involving increasing levels of risk, innovation, and multiple interdependent factors such as public-private partnerships (PPP), private finance initiative (PFI) and significant commercial and infrastructure schemes'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    When I check the following items:
      | Competition Law                   |
      | Project and Asset Finance         |
      | Public Law                        |
      | Public-Private Partnerships (PPP) |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 4 - Projects and Complex Advice including PPP'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services
    And the selected legal service suppliers are:
      | FERRY-BINS                    | http://ferry-bins.example/jayne.white                   |
      | SENGER, MUELLER AND WIEGAND   | http://sengermuellerandwiegand.example/dawna            |
      | SCHNEIDER-BRUEN               | http://schneider-bruen.example/graham.wehner            |
      | KLEIN-BECHTELAR               | http://klein-bechtelar.test/jeannine.klocko             |
      | KOSS LLC                      | http://kossllc.example/antone                           |
      | LEMKE, JOHNS AND KUTCH        | http://lemkejohnsandkutch.example/mabel.bartell         |
  Scenario: Check the supplier data - SME
    Given I click on 'FERRY-BINS'
    Then I am on the 'FERRY-BINS' page
    Then the supplier 'is not' an SME
    And the 'Partner' hourly rate is '£315.00'
    And the 'Legal Director/ Counsel or equivalent' hourly rate is '£280.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£245.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£210.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£175.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£140.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£105.00'
    And the 'Legal Project Managers' hourly rate is '£70.00'
    And the 'Legal Document Reviewers, Document Reviewers' hourly rate is '£175.00'
    And the contact details for the supplier are:
      | bins_ferry@jacobs.example                            |
      | (110) 641 7183                                       |
      | http://ferry-bins.example/loriann                    |
      | S39353 Walker Turnpike, Greenholtside, WV 55188-8260 |
