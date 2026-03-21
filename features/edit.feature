Feature: edit
  Edit package files

Scenario: Abort with no arguments
  When I run 'rush edit'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: PACKAGE'

Scenario: Show --help
  When I run 'rush edit --help'
  Then the exit code should mean success
  And stdout should include 'Edit package files'
  And stdout should include 'Default: main'

Scenario: Edit a package main file
  Given rush is properly configured
  And the command 'my-editor' is stubbed
  And the environment variable 'EDITOR' is set to 'my-editor'
  When I run 'rush edit hello'
  Then the exit code should mean success
  And stdout should match 'stubbed: my-editor .+/rush-repos/sample-repo/hello/main'

Scenario: Edit a specific package file
  Given rush is properly configured
  And the command 'my-editor' is stubbed
  And the environment variable 'EDITOR' is set to 'my-editor'
  When I run 'rush edit hello info'
  Then the exit code should mean success
  And stdout should match 'stubbed: my-editor .+/rush-repos/sample-repo/hello/info'

Scenario: Show error with an invalid package name
  Given rush is properly configured
  When I run 'rush edit no-such-package'
  Then the exit code should mean failure
  And stdout should include 'package not found: default:no-such-package'

Scenario: Show error with an invalid repo name
  Given rush is properly configured
  When I run 'rush edit no-such-repo:hello'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'

Scenario: Show error with an invalid file name
  Given rush is properly configured
  When I run 'rush edit hello no-such-file'
  Then the exit code should mean failure
  And stdout should include 'file not found:'
