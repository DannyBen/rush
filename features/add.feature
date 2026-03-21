Feature: add
  Register a local repository

Scenario: Abort with no arguments
  When I run 'rush add'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: REPO'

Scenario: Show --help
  When I run 'rush add --help'
  Then the exit code should mean success
  And stdout should include 'Register a local repository'

Scenario: Add an existing local repo
  Given I am in an isolated environment
  And the directory '~/rush-repos/sample-repo' exists
  When I run 'rush add sample ~/rush-repos/sample-repo'
  Then the exit code should mean success
  And stdout should include 'sample ='
  And stdout should include '/rush-repos/sample-repo'
  And the rush config file should exist
  And the rush config file should include 'sample = '
  And the rush config file should include '/rush-repos/sample-repo'
