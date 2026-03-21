Feature: push
  Git push one or all repositories

Scenario: Show --help
  When I run 'rush push --help'
  Then the exit code should mean success
  And stdout should include 'Git push one or all repositories'
  And stdout should include '--all, -a'
  And stdout should include '--message, -m TEXT'

Scenario: Skip the default configured non-git repository
  Given rush is properly configured
  When I run 'rush push'
  Then the exit code should mean success
  And stdout should include 'default: skipping (not a git repo)'

Scenario: Abort with an invalid repo name
  Given rush is properly configured
  When I run 'rush push no-such-repo'
  Then the exit code should mean failure
  And stdout should include 'no such repo: no-such-repo'

Scenario: Push a configured git repository
  Given I am in an isolated environment
  And the directory '~/repos/demo/.git' exists
  And the repository 'demo' is configured at '~/repos/demo'
  And the command 'git' is stubbed
  When I run 'rush push demo'
  Then the exit code should mean success
  And stdout should include 'push'
  And stdout should include 'demo: adding files'
  And stdout should include 'demo: committing'
  And stdout should include 'demo: pushing'
  And stdout should include 'stubbed: git add . --all'
  And stdout should include 'stubbed: git commit -am automatic commit'
  And stdout should include 'stubbed: git push'

Scenario: Apply chmod to new main and undo files before commit
  Given I am in an isolated environment
  And the directory '~/repos/demo/.git' exists
  And the repository 'demo' is configured at '~/repos/demo'
  And the command 'git' is stubbed
  And the environment variable 'STUB_GIT_DIFF_OUTPUT' is set to 'hello/main'
  When I run 'rush push demo'
  Then the exit code should mean success
  And stdout should include 'applying chmod +x'
  And stdout should include 'stubbed: git update-index --chmod=+x hello/main'

Scenario: Push all configured repositories
  Given rush is properly configured
  And the directory '~/repos/demo/.git' exists
  And the repository 'demo' is configured at '~/repos/demo'
  And the command 'git' is stubbed
  When I run 'rush push --all'
  Then the exit code should mean success
  And stdout should include 'demo: adding files'
  And stdout should include 'default: skipping (not a git repo)'
