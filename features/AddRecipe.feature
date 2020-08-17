Feature: User can add a recipe

Scenario: Add a recipe
    Given I am a registered user
    When I log in
    And I follow "Profile"
    And I follow "Add new recipe"
    Then I should be on the Create New Recipe Page
    When I fill in "recipe[title]" with "Maccheroni" 
    And I fill in "recipe[preparazione]" with "Pasta e pentole"
    And I attach the file "features/support/test_image.jpg" to "recipe[image]"
    And I press "Save changes"
    Then I should be on My Profile page
    And I should see "Maccheroni"
