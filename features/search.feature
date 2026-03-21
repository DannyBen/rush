Feature: search
  Search in package names and info files

Scenario: Abort with no arguments
  When I run 'rush search'
  Then the exit code should mean failure
  And stderr should include 'missing required argument: TEXT'

Scenario: Show --help
  When I run 'rush search --help'
  Then the exit code should mean success
  And stdout should include 'Search in package names and info files'
  And stdout should include 'Text to search for'

Scenario: Search package names
  Given rush is properly configured
  And the sample repository is available at '~/rush-repos/second-repo'
  And the repository 'sample' is configured at '~/rush-repos/second-repo'
  When I run 'rush search hello'
  Then the exit code should mean success
  And stdout should include 'Matching packages (default)'
  And stdout should include 'hello'
  And stdout should include 'Matching packages (sample)'
  And stdout should include 'sample:hello'

Scenario: Search info file contents
  Given rush is properly configured
  And the sample repository is available at '~/rush-repos/second-repo'
  And the repository 'sample' is configured at '~/rush-repos/second-repo'
  When I run 'rush search running'
  Then the exit code should mean success
  And stdout should include 'Matching info files (default)'
  And stdout should include 'This info file can be accessed by'
  And stdout should include 'Matching info files (sample)'
  And stdout should include 'sample:hello'
