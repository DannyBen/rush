Feature: info
  Show information about a package

Scenario: Abort with no arguments
  When I run 'rush info'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: PACKAGE'

Scenario: Show --help
  When I run 'rush info --help'
  Then the exit code should mean success
  And stdout should include 'Show information about a package'
  And stdout should include 'rush info ruby'

Scenario: Show information about a package
  Given rush is properly configured
  When I run 'rush info hello'
  Then the exit code should mean success
  And stdout should include 'This is a simple example'

Scenario: Show error with an invalid package name
  Given rush is properly configured
  When I run 'rush info no-such-package'
  Then the exit code should mean failure
  And stdout should include 'package not found: default:no-such-package'

Scenario: Show error with an invalid repo name
  Given rush is properly configured
  When I run 'rush info no-such-repo:hello'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'
