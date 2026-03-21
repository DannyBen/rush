Feature: show
  Show package files

Scenario: Abort with no arguments
  When I run 'rush show'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: PACKAGE'

Scenario: Show --help
  When I run 'rush show --help'
  Then the exit code should mean success
  And stdout should include 'Show package files'
  And stdout should include 'rush show docker'

Scenario: Show a package file
  Given rush is properly configured
  When I run 'rush show download main'
  Then the exit code should mean success
  And stdout should include 'cp .somefile'
  And stdout should include 'Saved'

Scenario: Show all package files
  Given rush is properly configured
  When I run 'rush show download'
  Then the exit code should mean success
  And stdout should include '.somefile'
  And stdout should include 'Shows how a script can copy files from its own folder'
  And stdout should include 'Removed'

Scenario: Show files for a nested package
  Given rush is properly configured
  When I run 'rush show nested'
  Then the exit code should mean success
  And stdout should include 'Nested packages'

Scenario: Show error with an invalid package name
  Given rush is properly configured
  When I run 'rush show no-such-package'
  Then the exit code should mean failure
  And stdout should include 'package not found: default:no-such-package'

Scenario: Show error with an invalid repo name
  Given rush is properly configured
  When I run 'rush show no-such-repo:download'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'

Scenario: Show error with an invalid file name
  Given rush is properly configured
  When I run 'rush show download no-such-file'
  Then the exit code should mean failure
  And stdout should include 'file not found:'
