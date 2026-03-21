Feature: get
  Install a package

Scenario: Abort with no arguments
  When I run 'rush get'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: PACKAGE'

Scenario: Show --help
  When I run 'rush get --help'
  Then the exit code should mean success
  And stdout should include 'Install a package'
  And stdout should include '--clone, -c'
  And stdout should include '--force, -f'

Scenario: Run a package from the default repository
  Given rush is properly configured
  When I run 'rush get hello'
  Then the exit code should mean success
  And stdout should include 'get'
  And stdout should include 'What'
  And stdout should include 'REPO:      default'

Scenario: Run a package from an explicit repository
  Given rush is properly configured
  And the sample repository is available at '~/rush-repos/second-repo'
  And the repository 'sample' is configured at '~/rush-repos/second-repo'
  When I run 'rush get sample:hello'
  Then the exit code should mean success
  And stdout should include 'sample:hello'
  And stdout should include 'REPO:      sample'

Scenario: Run a package using the default command behavior
  Given rush is properly configured
  When I run 'rush hello'
  Then the exit code should mean success
  And stdout should include 'What'
  And stdout should include 'REPO:      default'

Scenario: Run a package that writes to the current directory
  Given rush is properly configured
  When I run 'rush get download'
  Then the exit code should mean success
  And stdout should include 'Saved'
  And the file '~/.somefile' should exist

Scenario: Pass verbose and force flags to a package
  Given rush is properly configured
  When I run 'rush get hello -fv'
  Then the exit code should mean success
  And stdout should include 'VERBOSE:   1'
  And stdout should include 'FORCE:     1'

Scenario: Abort with an invalid package name
  Given rush is properly configured
  When I run 'rush get no-such-package'
  Then the exit code should mean failure
  And stdout should include 'package not found: default:no-such-package'

Scenario: Abort with an invalid repo name
  Given rush is properly configured
  When I run 'rush get no-such-repo:hello'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'
