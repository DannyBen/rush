Feature: config
  Show or edit the configuration file

Scenario: Show --help
  When I run 'rush config --help'
  Then the exit code should mean success
  And stdout should include 'Show or edit the configuration file'
  And stdout should include '--edit, -e'

Scenario: Show the config file
  Given rush is properly configured
  When I run 'rush config'
  Then the exit code should mean success
  And stdout should match 'default = .+/rush-repos/sample-repo'

Scenario: Edit the config file
  Given rush is properly configured
  And the command 'my-editor' is stubbed
  And the environment variable 'EDITOR' is set to 'my-editor'
  When I run 'rush config --edit'
  Then the exit code should mean success
  And stdout should match 'stubbed: my-editor .+/rush\.ini'
