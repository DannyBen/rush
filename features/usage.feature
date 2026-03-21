Feature: usage
  Basic usage output for rush

Scenario: Show usage with no arguments
  When I run 'rush'
  Then the exit code should mean failure
  And stderr should include 'Package Commands:'

Scenario: Show --help
  When I run 'rush --help'
  Then the exit code should mean success
  And stdout should include 'RUSH_CONFIG'

