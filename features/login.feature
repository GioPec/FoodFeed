Feature: User can login to 
  As a registered user
  So that I can interact with the system
  I want to log in the system

Scenario: Login success
  Given I am a registered user
  When I log in
  Then I should be on the Discover Page

Scenario: Login failure
  Given I am a registered user
  When I am on the login page
  And I fill in "Email" with "a@a.a"
  And I fill in "Password" with "aaaaaaa1"
  And I press "Log in"
  Then I should be on the login page
  And I should see "Log in"
  And I should see "Sign up"

