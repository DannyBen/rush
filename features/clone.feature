Feature: clone
  Clone a GitHub package repository

Scenario: Abort with no arguments
  When I run 'rush clone'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: GITHUB_USER'

Scenario: Show --help
  When I run 'rush clone --help'
  Then the exit code should mean success
  And stdout should include 'Clone a GitHub package repository'
  And stdout should include '--shallow, -w'
  And stdout should include '--ignore, -i'

Scenario: Clone a repository into the default location
  Given I am in an isolated environment
  And the command 'git' is stubbed
  When I run 'rush clone bobby'
  Then the exit code should mean success
  And stdout should include 'stubbed: git clone https://github.com/bobby/rush-repo.git'
  And the rush config file should match 'default = .+/rush-repos/bobby/rush-repo'
  And the directory '~/rush-repos/bobby/rush-repo' should exist

Scenario: Perform a shallow clone
  Given rush is properly configured
  And the command 'git' is stubbed
  When I run 'rush clone bobby --shallow'
  Then the exit code should mean success
  And stdout should include 'stubbed: git clone --depth 1 https://github.com/bobby/rush-repo.git'
  And the rush config file should match 'bobby = .+/rush-repos/bobby/rush-repo'

Scenario: Clone using SSH
  Given I am in an isolated environment
  And the command 'git' is stubbed
  When I run 'rush clone bobby --ssh'
  Then the exit code should mean success
  And stdout should include 'stubbed: git clone git@github.com:bobby/rush-repo.git'
  And the rush config file should match 'default = .+/rush-repos/bobby/rush-repo'

Scenario: Clone using an explicit name
  Given rush is properly configured
  And the command 'git' is stubbed
  When I run 'rush clone bobby --name somename'
  Then the exit code should mean success
  And the rush config file should match 'somename = .+/rush-repos/bobby/rush-repo'

Scenario: Clone as the default repository
  Given I am in an isolated environment
  And the file '~/rush.ini' contains
    """
    sample = ~/rush-repos/sample-repo
    """
  And the command 'git' is stubbed
  When I run 'rush clone bobby --default'
  Then the exit code should mean success
  And the rush config file should match 'default = .+/rush-repos/bobby/rush-repo'

Scenario: Abort when the target directory exists
  Given I am in an isolated environment
  And the command 'git' is stubbed
  And the directory '~/rush-repos/bobby/rush-repo' exists
  When I run 'rush clone bobby'
  Then the exit code should mean failure
  And stdout should include 'directory'
  And stdout should include 'already exists'

Scenario: Abort when the repository name is already registered
  Given rush is properly configured
  And the command 'git' is stubbed
  When I run 'rush clone bobby --name default'
  Then the exit code should mean failure
  And stdout should include 'the repository is already registered'
  And stdout should include 'default = '

Scenario: Skip when the target directory exists and --ignore is used
  Given I am in an isolated environment
  And the command 'git' is stubbed
  And the directory '~/rush-repos/bobby/rush-repo' exists
  When I run 'rush clone bobby --ignore'
  Then the exit code should mean success
  And stdout should include 'skipping default (exists)'

Scenario: Skip when the repository name is already registered and --ignore is used
  Given rush is properly configured
  And the command 'git' is stubbed
  When I run 'rush clone bobby --name default --ignore'
  Then the exit code should mean success
  And stdout should include 'skipping default (exists)'
