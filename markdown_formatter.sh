#!/bin/bash

check_python() {
  if ! command -v python3 &> /dev/null
  then
    echo "error: python tidak terinstal" >&2
    exit 1
  fi

  VERSI_PYTHON=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
  echo "versi python: $VERSI_PYTHON"
}

install_mdformat_run() {
  python3 -m pip install mdformat --quiet || { echo "gagal install mdformat"; exit 1; }
  echo "format markdown file"
  python3 -m mdformat .
}

check_python
install_mdformat_run
