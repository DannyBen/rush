Feature: debug
  Experiments and debug scenarios for development

Scenario: Stubbing test
  Given the command 'git' is stubbed
  When I run 'git status -a'
  Then the exit code should mean success
  And stdout should be 'stubbed: git status -a'
