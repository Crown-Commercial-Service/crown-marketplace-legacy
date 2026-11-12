Feature: Legal services -  Central government - Lot 2 - Suppliers

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
    And I select 'Government Policy' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Focused support for specific legal specialism(s)' for 'requirements'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    When I check the following items:
      |Artificial Intelligence and Machine Learning Law|
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 2 - Focused Legal Support'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '5' suppliers can provide legal services
    And the selected legal service suppliers are:
      | BEER, DICKI AND MULLER            | http://beerdickiandmuller.test/erasmo                  |
      | KIEHN, STAMM AND TORP             | http://kiehnstammandtorp.example/guillermina.romaguera |
      | JAST, SAUER AND VOLKMAN           | http://jastsauerandvolkman.test/kenyatta.streich       |
      | SMITHAM GROUP                     | http://smithamgroup.example/dirk_becker                |
      | FRITSCH, LANGWORTH AND STIEDEMANN | http://fritschlangworthandstiedemann.test/chung.orn    |
  Scenario: Check the supplier data - SME
    Given I click on 'BEER, DICKI AND MULLER'
    Then I am on the 'BEER, DICKI AND MULLER' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£270.00'
    And the 'Legal Director/ Counsel or equivalent' hourly rate is '£240.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£210.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£180.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£150.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£120.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£90.00'
    And the 'Legal Project Managers' hourly rate is '£60.00'
    And the 'Legal Document Reviewers, Document Reviewers' hourly rate is '£150.00'
    And the contact details for the supplier are:
      |beer.muller.and.dicki@abernathy.test                  |
      | (356) 560-1427                                       |
      | http://beerdickiandmuller.test/shizue.howe           |
      | Apt. 792 821 Micah Plaza, Port Refugiohaven, MD 00019|
