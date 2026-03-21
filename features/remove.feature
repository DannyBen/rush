Feature: remove
  Unregister a local repository

Scenario: Abort with no arguments
  When I run 'rush remove'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: REPO'

Scenario: Show --help
  When I run 'rush remove --help'
  Then the exit code should mean success
  And stdout should include 'Unregister a local repository'
  And stdout should include '--purge, -p'

Scenario: Remove a configured repository
  Given rush is properly configured
  When I run 'rush remove default'
  Then the exit code should mean success
  And stdout should include 'default'
  And the rush config file should not include 'default = '

Scenario: Remove and purge a configured repository
  Given rush is properly configured
  When I run 'rush remove default --purge'
  Then the exit code should mean success
  And stdout should include 'default'
  And stdout should include 'purged'
  And the rush config file should not include 'default = '
  And the directory '~/rush-repos/sample-repo' should not exist
