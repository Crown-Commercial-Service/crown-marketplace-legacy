Feature: Management Consultancy - Admin - Supplier details - Contact information

  Scenario: Contact information can be updated
    Given I sign in as an admin for the 'RM6309' framework in 'management consultancy'
    And I click on 'Manage supplier data'
    Then I am on the 'Supplier data' page
    And I click on 'View details' for 'MOSCISKI-CROOKS'
    Then I am on the 'Supplier details' page
    And the caption is 'MOSCISKI-CROOKS'
    And I should see the following details in the 'Contact information' summary:
      | Contact name             | Elton Leuschke                              |
      | Contact email            | crooks.mosciski@powlowski-daugherty.example |
      | Contact telephone number | 08704774229                                 |
      | Website                  | http://schultz.example/lance.cormier        |
    And I click on 'Change (Contact information)'
    Then I am on the 'Manage supplier contact information' page
    And the caption is 'MOSCISKI-CROOKS'
    And I enter the following details into the form:
      | Contact name             | An Unbroken Thread of Awareness                    |
      | Contact email            | an.unbroken.thread.of.awareness@gogopenguine.co.uk |
      | Contact telephone number | 01610 456123                                       |
      | Website                  | http://an.unbroken.thread.of.awareness.co.uk       |
    And I click on 'Save and return'
    Then I am on the 'Supplier details' page
    And the caption is 'MOSCISKI-CROOKS'
    And I should see the following details in the 'Contact information' summary:
      | Contact name             | An Unbroken Thread of Awareness                    |
      | Contact email            | an.unbroken.thread.of.awareness@gogopenguine.co.uk |
      | Contact telephone number | 01610 456123                                       |
      | Website                  | http://an.unbroken.thread.of.awareness.co.uk       |
