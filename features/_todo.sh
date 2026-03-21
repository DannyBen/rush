# This is the old approve test file, with only the not yet implemented feature
# tests. once we implement equivalt tests, we should delet ethem from here

describe "get"
  approve "rush add sample ~/rush-repos/sample-repo"
  approve "rush get" || return 0
  approve "rush get -h"
  approve "rush get hello"
  approve "rush get download"
  approve "rush get sample:hello"
  approve "rush hello"
  approve "rush get package-in-package/one"
  rush remove dannyben --purge > /dev/null
  approve "rush get dannyben:hello" || return 0
  approve "rush get dannyben:hello --clone"
  approve "rush get dannyben:hello" "rush_get_dannyben_hello_works"
  approve "rush hello --force"
  approve "rush hello --verbose"
  approve "rush get hello -fv"

describe "undo"
  approve "rush undo" || return 0
  approve "rush undo -h"
  approve "rush undo download"
  approve "rush undo sample:download"
  approve "rush undo sample:download --verbose"

describe "snatch"
  approve "rush snatch" || return 0
  approve "rush snatch -h"
  allow_diff "rush-snatch\.[0-9a-zA-Z]{6}"
  approve "rush snatch dannyben hello"
  allow_diff "rush-snatch\.[0-9a-zA-Z]{6}"
  approve "rush snatch dannyben hello --undo"
  allow_diff "rush-snatch\.[0-9a-zA-Z]{6}"
  approve "rush snatch dannyben hello --force --verbose"
  approve "ls /tmp/rush-snatch*"

describe "pull"
  approve "rush pull" || return 0
  approve "rush pull -h"

describe "push"
  approve "rush push" || return 0
  approve "rush push dannyben" || return 0
  approve "rush push --all" || return 0
  approve "rush push -h"

describe "remove"
  dir="/root/rush-repos/dannyben/rush-repo"
  approve "rush remove" || return 0
  approve "rush remove -h"
  approve "rush remove dannyben --purge"
  [[ -d $dir ]] && fail "Expected directory $dir to not exist"
  approve "rush remove dannyben"

describe "list"
  approve "rush list -h"
  approve "rush list"
  approve "rush list --simple"
  approve "rush list --all"
  approve "rush list --all --simple"
  approve "rush list hello"
  approve "rush list nope:thing" || return 0
  expect_exit_code 1
  approve "rush list sample"
  approve "rush list sample:asd"
  approve "rush list nested"
  approve "rush list sample:nested"
  approve "rush list no-such-package"
  approve "COLUMNS=40 rush list"

describe "search"
  approve "rush search" || return 0
  approve "rush search -h"
  approve "rush search running"
  approve "rush search hello"

describe "copy"
  mkdir ~/rush-repos/target
  rush add default ~/rush-repos/target > /dev/null
  approve "rush copy" || return 0
  approve "rush copy -h"
  approve "rush copy sample:hello"
  approve "ls ~/rush-repos/target/hello" "rush_copy_files_list"
  approve "rush copy sample:download download1"
  approve "rush copy sample:download default:download2" "rush_copy_sample_download_default_download2_1-of-2"
  approve "rush copy sample:download default:download2" "rush_copy_sample_download_default_download2_2-of-2" || return 0
  approve "rush copy sample:download default:download2 -f"
  approve "ls -R ~/rush-repos/target" "rush_copy_files_list2"

describe "completions"
  approve "rush completions"
  approve "rush completions -h"
