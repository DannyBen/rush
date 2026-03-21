Feature: list
  Show packages in one or all repositories

Scenario: Show --help
  When I run 'rush list --help'
  Then the exit code should mean success
  And stdout should include 'Show packages in one or all repositories'
  And stdout should include '--simple, -s'
  And stdout should include '--all, -a'

Scenario: Show packages in the default repository
  Given rush is properly configured
  When I run 'rush list'
  Then the exit code should mean success
  And stdout should include 'bootstrap'
  And stdout should include 'This is a simple example.'

Scenario: Show package names only
  Given rush is properly configured
  When I run 'rush list --simple'
  Then the exit code should mean success
  And stdout should be
    """
    bootstrap
    download
    hello
    nested
    """

Scenario: Show nested packages for a package name
  Given rush is properly configured
  When I run 'rush list nested'
  Then the exit code should mean success
  And stdout should include 'nested/hi'

Scenario: Show error with an invalid repo name
  Given rush is properly configured
  When I run 'rush list nope:thing'
  Then the exit code should mean failure
  And stdout should include 'repo not found: nope'
