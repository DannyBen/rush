Feature: snatch
  Clone and run a package from a temporary repository

Scenario: Abort with no arguments
  When I run 'rush snatch'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: GITHUB_USER'

Scenario: Show --help
  When I run 'rush snatch --help'
  Then the exit code should mean success
  And stdout should include 'Install a package from a remote repo.'
  And stdout should include '--undo, -u'
  And stdout should include '--force, -f'

Scenario: Get a package from a temporary cloned repository
  Given I am in an isolated environment
  And the command 'git' is stubbed
  And git clone populates the cloned repository with the sample fixture
  When I run 'rush snatch bobby hello'
  Then the exit code should mean success
  And stdout should include 'stubbed: git clone https://github.com/bobby/rush-repo.git'
  And stdout should include 'What'
  And stdout should include 'REPO:      snatched'
  And the rush config file should not include 'snatched ='
  And the temporary directory should not contain entries matching 'rush-snatch.*'

Scenario: Undo a package from a temporary cloned repository
  Given I am in an isolated environment
  And the file '~/.somefile' contains
    """
    temp
    """
  And the command 'git' is stubbed
  And git clone populates the cloned repository with the sample fixture
  When I run 'rush snatch bobby download --undo'
  Then the exit code should mean success
  And stdout should include 'Removed'
  And the file '~/.somefile' should not exist
  And the rush config file should not include 'snatched ='
  And the temporary directory should not contain entries matching 'rush-snatch.*'

Scenario: Pass force and verbose flags to the temporary package
  Given I am in an isolated environment
  And the command 'git' is stubbed
  And git clone populates the cloned repository with the sample fixture
  When I run 'rush snatch bobby hello --force --verbose'
  Then the exit code should mean success
  And stdout should include 'stubbed: git clone https://github.com/bobby/rush-repo.git'
  And stdout should include 'VERBOSE:   1'
  And stdout should include 'FORCE:     1'
  And the rush config file should not include 'snatched ='
  And the temporary directory should not contain entries matching 'rush-snatch.*'
