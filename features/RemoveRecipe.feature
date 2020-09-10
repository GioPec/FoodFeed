Feature: User can remove a recipe

Scenario: Remove a recipe
    Given I am a registered user
    When I add a recipe
    And I follow "Image"
    Then I should be on the Recipe page
    And I press "Remove post"
    #And I press "OK"
    Then I should be on My Profile page
    And I should not see "Maccheroni"
