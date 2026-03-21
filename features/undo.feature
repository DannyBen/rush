Feature: undo
  Uninstall a package

Scenario: Abort with no arguments
  When I run 'rush undo'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: PACKAGE'

Scenario: Show --help
  When I run 'rush undo --help'
  Then the exit code should mean success
  And stdout should include 'Uninstall a package'
  And stdout should include '--verbose, -v'

Scenario: Run the undo script for a package
  Given rush is properly configured
  And the file '~/.somefile' contains
    """
    temp
    """
  When I run 'rush undo download'
  Then the exit code should mean success
  And stdout should include 'undo'
  And stdout should include 'Removed'
  And stdout should include 'VERBOSE:'
  And the file '~/.somefile' should not exist

Scenario: Run the undo script for an explicit repository package
  Given rush is properly configured
  And the sample repository is available at '~/rush-repos/second-repo'
  And the repository 'sample' is configured at '~/rush-repos/second-repo'
  And the file '~/.somefile' contains
    """
    temp
    """
  When I run 'rush undo sample:download'
  Then the exit code should mean success
  And stdout should include 'sample:download'
  And stdout should include 'Removed'

Scenario: Run the undo script with verbose mode
  Given rush is properly configured
  And the file '~/.somefile' contains
    """
    temp
    """
  When I run 'rush undo download --verbose'
  Then the exit code should mean success
  And stdout should include 'VERBOSE: 1'

Scenario: Abort with an invalid package name
  Given rush is properly configured
  When I run 'rush undo no-such-package'
  Then the exit code should mean failure
  And stdout should include 'package not found: default:no-such-package'

Scenario: Abort with an invalid repo name
  Given rush is properly configured
  When I run 'rush undo no-such-repo:download'
  Then the exit code should mean failure
  And stdout should include 'repo not found: no-such-repo'

Scenario: Abort when the undo script does not exist
  Given rush is properly configured
  When I run 'rush undo hello'
  Then the exit code should mean failure
  And stdout should include 'script not found:'
