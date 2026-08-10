Feature: Legal services -  Central government - Lot 5 - Suppliers

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
    And I select 'Education' for 'select customer sector'
    And I click on 'Continue'
    Then I am on the 'Do you require' page
    And I select 'Legal services across a broad range of legal specialisms (Full Service Provision)'
    And I click on 'Continue'
    Then I am on the 'Select legal services required' page
    When I check the following items:
      | Artificial Intelligence and Machine Learning Law |
      | Assimilated Law                                  |
      | Aviation and Airports                            |
      | Charities                                        |
      | Children and Vulnerable Adults                   |
    And I click on 'Continue'
    Then I am on the 'Lots that meet your requirements' page

  Scenario: On 'lots that meet your requirements' page journey for option 'Continue with the recommended Lot 1a...'
    Given I select 'Continue with Lot 1a - Full Legal Service Provision for all Public Sector'
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need' page
    And the sub title is 'Lot 1 - Full Legal Service Provision for all Public Sector'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | SCHUMM AND SONS   | http://schummandsons.test/oswaldo.batz    |
      | BOGAN INC         | http://boganinc.example/florencio         |
      | BAUMBACH AND SONS | http://baumbachandsons.example/rudy       |
      | WATERS INC        | http://watersinc.test/letty               |
      | ZIEMANN INC       | http://ziemanninc.example/mallory.kuvalis |
      | BLOCK-WINTHEISER  | http://block-wintheiser.test/angelo       |
    And I click on 'BOGAN INC'
    And I am on the 'BOGAN INC' page
    And the supplier 'is' an SME
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
      | inc.bogan@anderson-quigley.example                        |
      | (248) 674-4004                                            |
      | http://boganinc.example/donnell_wisoky                    |
      | Apt. 243 14784 Collier Throughway, Raymondeville, AR 94753-1876 |

  Scenario Outline: : On 'lots that meet your requirements' page, journey for option 'Select another lot'
    Given I select 'Select another lot'
    And I click on 'Continue'
    Then the alternative lot options list should be displayed
    And the available alternative lots should include:
      | Lot 1b - Full Legal Service Provision for Local Government and Local Communities |
      | Lot 1c - Full Legal Service Provision for Health and Social Care                 |
      | Lot 2 - Focused Legal Support                                                    |
    And I select '<AlternativeLot>' from the alternative lots list
    And I click on 'Continue'
    Then I am on the 'Select the jurisdiction you need'  page
    And the sub title is '<ExpectedSubTitle>'
    And I select 'England and Wales'
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '7' suppliers can provide legal services
    And the selected legal service suppliers are:
      | SCHUMM AND SONS   | http://schummandsons.test/oswaldo.batz    |
      | BOGAN INC         | http://boganinc.example/florencio         |
      | BAUMBACH AND SONS | http://baumbachandsons.example/rudy       |
      | WATERS INC        | http://watersinc.test/letty               |
      | ZIEMANN INC       | http://ziemanninc.example/mallory.kuvalis |
      | BLOCK-WINTHEISER  | http://block-wintheiser.test/angelo       |
    And I click on 'BOGAN INC'
    And I am on the 'BOGAN INC' page
    And the supplier 'is' an SME
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
      | inc.bogan@anderson-quigley.example                              |
      | (248) 674-4004                                                  |
      | http://boganinc.example/donnell_wisoky                          |
      | Apt. 243 14784 Collier Throughway, Raymondeville, AR 94753-1876 |
    Examples:
      | AlternativeLot                                                                    | ExpectedSubTitle          |
      | Lot 1b - Full Legal Service Provision for Local Government and Local Communities  | Lot 1 - Full Legal Service Provision for Local Government and Local Communities   |
      | Lot 1c - Full Legal Service Provision for Health and Social Care                  | Lot 1 - Full Legal Service Provision for Health and Social Care                   |
      | Lot 2 - Focused Legal Support                                                     | Lot 2 - Focused Legal Support                                                     |


