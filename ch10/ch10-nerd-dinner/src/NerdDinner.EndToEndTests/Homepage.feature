Feature: Nerd Dinner Homepage
	As a Nerd Dinner user
	I want to see a modern responsive homepage
	So that I'm enouraged to engage with the app

Scenario: Visit homepage
	Given I navigate to the app at "http://nerd-dinner-test"
	When I see the homepage 
	Then the heading should contain "Nerd Dinner 2.0!"