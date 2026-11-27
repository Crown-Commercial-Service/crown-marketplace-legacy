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
    Given I click on 'SCHNEIDER, ARMSTRONG AND ABERNATHY SME'
    Then I am on the 'SCHNEIDER, ARMSTRONG AND ABERNATHY SME' page
    And the 'Partner' hourly rate is '<partner_rate>'
    And the 'Legal Director/ Counsel or equivalent' hourly rate is '<legal_director_rate>'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '<senior_solicitor_rate>'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '<solicitor_rate>'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '<nq_solicitor_rate>'
    And the 'Trainee/Legal Apprentice' hourly rate is '<trainee_rate>'
    And the 'Paralegal, Legal Assistant' hourly rate is '<paralegal_rate>'
    And the 'Legal Project Managers' hourly rate is '<legal_project_manager_rate>'
    And the 'Legal Document Reviewers, Document Reviewers' hourly rate is '<legal_document_reviewer_rate>'

    Examples:
      | partner_rate | legal_director_rate | senior_solicitor_rate | solicitor_rate | nq_solicitor_rate | trainee_rate | paralegal_rate | legal_project_manager_rate | legal_document_reviewer_rate |
      | £270.00      | £240.00             | £210.00               | £180.00        | £150.00           | £120.00      | £90.00         | £60.00                     | £150.00                      |