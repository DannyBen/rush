Feature: default
  Set a default repository

Scenario: Abort with no arguments
  When I run 'rush default'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: REPO'

Scenario: Show --help
  When I run 'rush default --help'
  Then the exit code should mean success
  And stdout should include 'Set a default repository'
  And stdout should include 'rush default sample'

Scenario: Set the default repository
  Given I am in an isolated environment
  And the directory '~/rush-repos/sample-repo' exists
  And the repository 'sample' is configured at '~/rush-repos/sample-repo'
  When I run 'rush default sample'
  Then the exit code should mean success
  And stdout should include 'sample ('
  And the rush config file should match 'default = .+/rush-repos/sample-repo'
  And the rush config file should not include 'sample = '

Scenario: Abort when the source repo is default
  Given rush is properly configured
  When I run 'rush default default'
  Then the exit code should mean failure
  And stdout should include 'cannot use'

Scenario: Abort with an invalid repo name
  Given rush is properly configured
  When I run 'rush default no-such-repo'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'
