Feature: copy
  Copy a package between local repositories

Scenario: Abort with no arguments
  When I run 'rush copy'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: SOURCE_PACKAGE'

Scenario: Show --help
  When I run 'rush copy --help'
  Then the exit code should mean success
  And stdout should include 'Copy a package between local repositories'
  And stdout should include '--force, -f'

Scenario: Copy a package to the default repository
  Given I am in an isolated environment
  And the sample repository is available at '~/rush-repos/sample-repo'
  And the repository 'sample' is configured at '~/rush-repos/sample-repo'
  And the directory '~/rush-repos/target-repo' exists
  And the repository 'default' is configured at '~/rush-repos/target-repo'
  When I run 'rush copy sample:hello'
  Then the exit code should mean success
  And stdout should include 'sample:hello to hello'
  And the file '~/rush-repos/target-repo/hello/info' should exist
  And the file '~/rush-repos/target-repo/hello/main' should exist

Scenario: Copy a package with a new target name
  Given I am in an isolated environment
  And the sample repository is available at '~/rush-repos/sample-repo'
  And the repository 'sample' is configured at '~/rush-repos/sample-repo'
  And the directory '~/rush-repos/target-repo' exists
  And the repository 'default' is configured at '~/rush-repos/target-repo'
  When I run 'rush copy sample:download download1'
  Then the exit code should mean success
  And stdout should include 'sample:download to download1'
  And the file '~/rush-repos/target-repo/download1/undo' should exist

Scenario: Abort when the target package already exists
  Given I am in an isolated environment
  And the sample repository is available at '~/rush-repos/sample-repo'
  And the repository 'sample' is configured at '~/rush-repos/sample-repo'
  And the directory '~/rush-repos/target-repo' exists
  And the repository 'default' is configured at '~/rush-repos/target-repo'
  And the file '~/rush-repos/target-repo/download2/info' contains
    """
    old content
    """
  When I run 'rush copy sample:download download2'
  Then the exit code should mean failure
  And stdout should include 'target package already exists'

Scenario: Overwrite an existing target package with force
  Given I am in an isolated environment
  And the sample repository is available at '~/rush-repos/sample-repo'
  And the repository 'sample' is configured at '~/rush-repos/sample-repo'
  And the directory '~/rush-repos/target-repo' exists
  And the repository 'default' is configured at '~/rush-repos/target-repo'
  And the file '~/rush-repos/target-repo/download2/info' contains
    """
    old content
    """
  When I run 'rush copy sample:download download2 --force'
  Then the exit code should mean success
  And stdout should include 'sample:download to download2'
  And the file '~/rush-repos/target-repo/download2/info' should include 'Shows how a script can copy files from its own folder'
  And the file '~/rush-repos/target-repo/download2/undo' should exist

Scenario: Abort with an invalid source repo
  Given rush is properly configured
  When I run 'rush copy no-such-repo:hello'
  Then the exit code should mean failure
  And stdout should include 'source repo not found: no-such-repo'

Scenario: Abort with an invalid source package
  Given rush is properly configured
  When I run 'rush copy no-such-package'
  Then the exit code should mean failure
  And stdout should include 'source package not found: default:no-such-package'
