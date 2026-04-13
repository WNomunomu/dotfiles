#!/bin/bash
set -e

OS="$(uname -s)"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

case "$OS" in
  Darwin) bash "$SCRIPT_DIR/mac/install.sh" ;;
  Linux)  bash "$SCRIPT_DIR/win/install.sh" ;;  # WSL
  *)      echo "Unsupported OS: $OS" && exit 1 ;;
esac
