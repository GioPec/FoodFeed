Feature: User can add a comment

Scenario: Add a recipe
    Given I am a registered user
    When I add a recipe
    And I follow "Profile"
    And I follow "Image"
    Then I should be on the Recipe page
    When I fill in "comment[body]" with "bella ricetta" 
    And I press "Post"
    Then I should be on the Recipe page
    And I should see "bella ricetta"