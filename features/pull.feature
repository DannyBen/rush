Feature: pull
  Git pull one or all repositories

Scenario: Show --help
  When I run 'rush pull --help'
  Then the exit code should mean success
  And stdout should include 'Git pull one or all repositories'
  And stdout should include 'Alias: p, download, update'

Scenario: Pull a configured git repository
  Given I am in an isolated environment
  And the directory '~/repos/demo/.git' exists
  And the repository 'demo' is configured at '~/repos/demo'
  And the command 'git' is stubbed
  When I run 'rush pull demo'
  Then the exit code should mean success
  And stdout should include 'pull'
  And stdout should include 'stubbed: git pull'

Scenario: Abort with an invalid repo name
  Given rush is properly configured
  When I run 'rush pull no-such-repo'
  Then the exit code should mean failure
  And stdout should include 'no such repo: no-such-repo'

Scenario: Skip a configured non-git repository
  Given rush is properly configured
  When I run 'rush pull default'
  Then the exit code should mean success
  And stdout should include 'skipping default (not a git repo)'

Scenario: Pull all configured repositories
  Given rush is properly configured
  And the directory '~/repos/demo/.git' exists
  And the repository 'demo' is configured at '~/repos/demo'
  And the command 'git' is stubbed
  When I run 'rush pull'
  Then the exit code should mean success
  And stdout should include 'skipping default (not a git repo)'
  And stdout should include 'stubbed: git pull'
