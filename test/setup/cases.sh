#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="/repo/test/tmp/setup"
mkdir -p "$LOG_DIR"

run_case() {
  local id="$1"
  local title="$2"
  local log="$LOG_DIR/${id}.log"

  echo "Running ${id}: ${title}"
  if "case_${id}" >"$log" 2>&1; then
    echo "PASS ${id} (log: $log)"
  else
    local code=$?
    echo "FAILED ${id} (exit code: ${code})"
    echo "--- ${log} (last 40 lines) ---"
    tail -n 40 "$log" || true
    exit "$code"
  fi
}

case_1() {
  cd /repo
  bash setup
  command -v rush | grep -q '^/usr/local/bin/rush$'
  [[ -x /usr/local/bin/rush ]]
  bash uninstall
  [[ ! -e /usr/local/bin/rush ]]
}

case_2() {
  su - withsudo -c 'cd /repo && bash setup'
  su - withsudo -c 'command -v rush' | grep -q '^/usr/local/bin/rush$'
  [[ -x /usr/local/bin/rush ]]
  su - withsudo -c 'cd /repo && bash uninstall'
  [[ ! -e /usr/local/bin/rush ]]
}

case_3() {
  su - nosudo -c 'mkdir -p ~/.local/bin ~/.local/share/bash-completion/completions ~/.local/share/man/man1'
  su - nosudo -c "export PATH=\"\$HOME/.local/bin:\$PATH\"; cd /repo && bash setup"
  su - nosudo -c "export PATH=\"\$HOME/.local/bin:\$PATH\"; command -v rush" | grep -q '^/home/nosudo/.local/bin/rush$'
  su - nosudo -c 'test -x ~/.local/bin/rush'
  su - nosudo -c "export PATH=\"\$HOME/.local/bin:\$PATH\"; cd /repo && bash uninstall"
  su - nosudo -c 'test ! -e ~/.local/bin/rush'
}

case_4() {
  if su - nosudo -c 'PATH="/usr/bin:/bin"; cd /repo && bash setup' >"$LOG_DIR/case4-output.log" 2>&1; then
    echo "case 4 unexpectedly succeeded"
    exit 1
  fi
  grep -q 'Cannot choose an install location automatically' "$LOG_DIR/case4-output.log"
}

echo "Preparing users"
useradd -m -s /bin/bash withsudo || true
useradd -m -s /bin/bash nosudo || true
echo 'withsudo ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/withsudo
chmod 440 /etc/sudoers.d/withsudo

run_case 1 "root installs to /usr/local"
run_case 2 "non-root with sudo installs to /usr/local"
run_case 3 "non-root without sudo installs to ~/.local"
run_case 4 "fails when no sudo and ~/.local/bin is not in PATH"

echo "All setup/uninstall cases passed"
