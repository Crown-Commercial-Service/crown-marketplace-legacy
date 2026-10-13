Feature: Legal services -  Central government - Lot 3 - Suppliers

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
    And I select 'Local Community & Housing' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Legal services in relation to litigation and dispute resolution' for 'requirements'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    When I check the following items:
      |Commercial Litigation and Dispute Resolution              |
      |Debt Recovery                                             |
      |Dispute Resolution and Litigation Law                     |
      |Employment Litigation and Dispute Resolution              |
      |Financial Litigation                                      |
      |Private Law Litigation and Dispute Resolution             |
      |Property and Real Estate Litigation and Dispute Resolution|
      |Public Law Litigation and Dispute Resolution              |
      |Statutory Civil Recovery                                  |
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 3 - Litigation and Disputes'
    And I select 'Northern Ireland'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '6' suppliers can provide legal services
    And the selected legal service suppliers are:
      | KAUTZER, BOTSFORD AND WIZA  | http://kautzerbotsfordandwiza.test/armando           |
      | SIPES, SCHILLER AND ULLRICH  | http://sipesschillerandullrich.test/julieta.quigley |
      | MAYER LLC SME                | http://mayerllc.example/denver                      |
      | KLEIN-BECHTELAR              | http://klein-bechtelar.test/dalton                  |
      | CRIST, LEFFLER AND WIEGAND   | http://cristlefflerandwiegand.example/lamont        |
      | SMITHAM GROUP SME            | http://smithamgroup.example/berry                   |
  Scenario: Check the supplier data - SME
    Given I click on 'MAYER LLC'
    Then I am on the 'MAYER LLC' page
    Then the supplier 'is' an SME
    And the 'Partner' hourly rate is '£225.00'
    And the 'Legal Director/ Counsel or equivalent' hourly rate is '£200.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£175.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Exec' hourly rate is '£125.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£100.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£75.00'
    And the 'Legal Project Managers' hourly rate is '£50.00'
    And the 'Legal Document Reviewers, Document Reviewers' hourly rate is '£125.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£245.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£210.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£175.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£140.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£105.00'
    And the contact details for the supplier are:
      | mayer.llc@ferry-abernathy.test                     |
      | 765-145-9838                                       |
      | http://mayerllc.example/gayle                      |
      | 2999 Daugherty Trail, Michalfort, FL 95326-1256    |
