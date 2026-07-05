Feature: menu
  Show packages in one or all repositories using fzf interactive menu

Scenario: Show --help
  When I run 'rush menu --help'
  Then the exit code should mean success
  And stdout should include 'Select a package from an interactive menu'
  And stdout should include '--install, -i'

Scenario: Show packages in the default repository
  Given rush is properly configured
  And the command 'fzf' is stubbed
  And my fzf selection will be 'hello'
  When I run 'rush menu'
  Then the fzf menu should show
    """
    ▌ package-in-package/two  Package two
    ▌ package-in-package/one  Package one
    ▌ nested/hi             Shows how to use nested folders
    ▌ hello                 This is a simple example.
    ▌ download              Shows how a script can copy files from its own folder
    ▌ bootstrap             Shows how to run another command from the same reposi·
    """
  And the exit code should mean success
  And stdout should include 'This info file can be accessed by running'

Scenario: Show packages in the a nested package
  Given rush is properly configured
  And the command 'fzf' is stubbed
  And my fzf selection will be 'nested/hi'
  When I run 'rush menu nested'
  Then the fzf menu should show
    """
    ▌ nested/hi             Shows how to use nested folders
    """
  Then the exit code should mean success
  And stdout should include '$ rush info nested/hi'

Scenario: Install package
  Given rush is properly configured
  And the command 'fzf' is stubbed
  And my fzf selection will be 'hello'
  When I run 'rush menu --install'
  Then the exit code should mean success
  And stdout should include 'What's the rush'
  And stdout should include 'REPO:      default'
