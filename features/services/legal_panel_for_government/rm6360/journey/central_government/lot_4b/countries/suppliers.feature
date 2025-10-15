@javascript
Feature: Legal Panel for Government - Non central governemnt - Lot 4b - Suppliers - Countries

  Scenario: Check the supplier data for different counties
    Given I sign in and navigate to the start page for the 'RM6360' framework in 'legal panel for government'
    Then I am on the 'Your account' page
    And I click on 'Search for suppliers'
    Then I am on the 'Do you work for central government or an arms length body?' page
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Information about your requirements' page
    And I enter '10/2024' for the requirement 'start' date
    And I enter '10/2025' for the requirement 'end' date
    And I enter '123456' for the 'requirement estimated total value'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the lot you need' page
    And I select 'Lot 4b - International Trade Disputes'
    And I click on 'Continue'
    Then I am on the 'Is your requirement for a location outside of the countries listed below?' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    And I select 'Yes'
    And I click on 'Continue'
    Then I am on the 'Select the countries for your requirement' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    When I check the following items:
      | Algeria        |
      | Cayman Islands |
    And I click on 'Continue'
    Then I am on the 'Select the legal specialisms you need' page
    And the sub title is 'Lot 4b - International Trade Disputes'
    When I check the following items:
      | Wider trading arrangements |
    And I click on 'Continue'
    Then I am on the 'Supplier results' page
    And I should see that '4' suppliers can provide legal specialisms for government
    And the selected legal service for government suppliers are:
      | ADAMS, WOLFF AND STROMAN   | http://gleichner-lowe.example/freddie           |
      | KOELPIN, HILLL AND COLLINS | http://goyette-reynolds.example/josefa.mosciski |
      | SANFORD INC                | http://murazik-bechtelar.test/neda              |
      | VEUM, TORPHY AND NOLAN     | http://gislason-murazik.example/dorthy          |
    And I click on 'Compare the supplier rates'
    Then I am on the 'Have you reviewed the suppliers’ prospectus to inform your down-selection?' page
    And I select 'No'
    And I click on 'Continue'
    Then I am on the 'Compare supplier rates' page
    Given I click on 'SANFORD INC' legal panel for governemnt supplier
    Then I am on the 'SANFORD INC' page
    And I click on 'Algeria'
    And the 'Senior Counsel, Senior Partner (20 years +PQE)' hourly rate is '£270.00'
    And the 'Partner' hourly rate is '£240.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£210.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£180.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£150.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£120.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£72.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£60.00'
    And the 'Senior Analyst' hourly rate is '£150.00'
    And the 'Analyst, Associate Analyst, Research Associate, Research Officer' hourly rate is '£120.00'
    And the 'Senior Modeller, Senior Econometrician, Senior Analyst' hourly rate is '£180.00'
    And the 'Modeller, Econometrician, Analyst, Associate Analyst' hourly rate is '£150.00'
    And I click on 'Cayman Islands'
    And the 'Senior Counsel, Senior Partner (20 years +PQE)' hourly rate is '£225.00'
    And the 'Partner' hourly rate is '£200.00'
    And the 'Legal Director/Counsel or equivalent' hourly rate is '£175.00'
    And the 'Senior Solicitor, Senior Associate/Senior Legal Executive' hourly rate is '£150.00'
    And the 'Solicitor, Associate/Legal Executive' hourly rate is '£125.00'
    And the 'NQ Solicitor/Associate, Junior Solicitor/Associate/Legal Executive' hourly rate is '£100.00'
    And the 'Trainee/Legal Apprentice' hourly rate is '£60.00'
    And the 'Paralegal, Legal Assistant' hourly rate is '£50.00'
    And the 'Senior Analyst' hourly rate is '£125.00'
    And the 'Analyst, Associate Analyst, Research Associate, Research Officer' hourly rate is '£100.00'
    And the 'Senior Modeller, Senior Econometrician, Senior Analyst' hourly rate is '£150.00'
    And the 'Modeller, Econometrician, Analyst, Associate Analyst' hourly rate is '£125.00'
