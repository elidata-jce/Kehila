#!/usr/bin/env bash
# install-git-unix.sh
# Usage:
#   sudo ./install-git-unix.sh --name "Your Name" --email "you@example.com" [--ssh]
#
# Installs git on macOS or major Linux distros, configures user.name/email,
# optionally generates an SSH key and prints the public key for GitHub.

set -e

PROGNAME=$(basename "$0")
NAME=""
EMAIL=""
GEN_SSH=0


if [ $# -eq 0 ]; then
  cat <<EOF
Usage: $PROGNAME [--name "Full Name"] [--email "email"] [--ssh] [--help]

Options:
  --name    Full name to set as git user.name
  --email   Email to set as git user.email
  --ssh     Generate an ed25519 SSH keypair (~/.ssh/id_ed25519) and print the public key
  -h, --help
            Show this help and exit

Examples:
  sudo ./$PROGNAME --name "Jane Doe" --email "jane@example.com" --ssh
  sudo ./$PROGNAME --ssh

If you run with no arguments this help is shown and the script exits.
EOF
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name) NAME="$2"; shift 2 ;;
    --email) EMAIL="$2"; shift 2 ;;
    --ssh) GEN_SSH=1; shift ;;
    -h|--help) echo "Usage: $PROGNAME [--name \"Full Name\"] [--email \"email\"] [--ssh]"; exit 0 ;;
    *) echo "Unknown arg: $1"; echo "Usage: $PROGNAME [--name \"Full Name\"] [--email \"email\"] [--ssh]"; exit 1 ;;
  esac
done

echo "Detecting OS..."
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux) PLATFORM="linux" ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

install_git_macos() {
  if command -v brew >/dev/null 2>&1; then
    echo "Installing git with Homebrew..."
    brew update
    brew install git
  else
    echo "Homebrew not found. Attempting to install Xcode command line tools (interactive)."
    echo "If you prefer Homebrew, install it first: https://brew.sh/"
    xcode-select --install || true
    # xcode-select installs git as part of command line tools; confirm later
  fi
}

install_git_linux() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "Detected apt-get (Debian/Ubuntu). Installing git..."
    sudo apt-get update
    sudo apt-get install -y git
  elif command -v dnf >/dev/null 2>&1; then
    echo "Detected dnf (Fedora/RHEL). Installing git..."
    sudo dnf install -y git
  elif command -v yum >/dev/null 2>&1; then
    echo "Detected yum. Installing git..."
    sudo yum install -y git
  elif command -v pacman >/dev/null 2>&1; then
    echo "Detected pacman (Arch). Installing git..."
    sudo pacman -Sy --noconfirm git
  elif command -v zypper >/dev/null 2>&1; then
    echo "Detected zypper (openSUSE). Installing git..."
    sudo zypper install -y git
  else
    echo "Could not detect package manager. Please install git manually."
    exit 1
  fi
}

echo "Installing Git for $PLATFORM..."
if [ "$PLATFORM" = "macos" ]; then
  install_git_macos
else
  install_git_linux
fi

echo
echo "Verifying installation..."
if ! command -v git >/dev/null 2>&1; then
  echo "Git not found after attempted install. Please install Git manually and re-run this script."
  exit 1
fi
git --version

# Ask for name/email if not provided
if [ -z "$NAME" ]; then
  read -rp "Enter git user.name (Full Name) or leave blank to skip: " NAME
fi
if [ -z "$EMAIL" ]; then
  read -rp "Enter git user.email (you@example.com) or leave blank to skip: " EMAIL
fi

if [ -n "$NAME" ]; then
  git config --global user.name "$NAME"
  echo "Set git user.name -> $NAME"
fi
if [ -n "$EMAIL" ]; then
  git config --global user.email "$EMAIL"
  echo "Set git user.email -> $EMAIL"
fi

# sensible defaults for EOL handling
if [ "$PLATFORM" = "macos" ] || [ "$PLATFORM" = "linux" ]; then
  git config --global core.autocrlf input || true
else
  git config --global core.autocrlf true || true
fi

git config --global color.ui auto

if [ "$GEN_SSH" -eq 1 ]; then
  SSH_DIR="$HOME/.ssh"
  mkdir -p "$SSH_DIR"
  KEYFILE="$SSH_DIR/id_ed25519"
  if [ -f "$KEYFILE" ] || [ -f "$KEYFILE.pub" ]; then
    echo "An SSH key already exists at $KEYFILE. Skipping generation."
  else
    echo "Generating an ed25519 SSH key (no passphrase)..."
    ssh-keygen -t ed25519 -C "${EMAIL:-"git@localhost"}" -f "$KEYFILE" -N "" || {
      echo "ssh-keygen failed. Install OpenSSH client tools and retry."
      exit 1
    }
    echo "Starting ssh-agent and adding key..."
    if command -v ssh-agent >/dev/null 2>&1; then
      eval "$(ssh-agent -s)"
      ssh-add "$KEYFILE" || true
    fi
  fi

  echo
  echo "Public key (copy/paste into GitHub -> Settings -> SSH and GPG keys -> New SSH key):"
  echo "--------------------------------------------------------------------------------"
  cat "${KEYFILE}.pub" || true
  echo "--------------------------------------------------------------------------------"
  echo "If you prefer to copy the key: (mac) pbcopy < ~/.ssh/id_ed25519.pub ; (linux) xclip -selection clipboard < ~/.ssh/id_ed25519.pub"
fi

echo
echo "Done. Useful next steps:"
echo "  git --version"
echo "  git config --list --show-origin"
echo "  In VS Code: File -> Open Folder -> open your project"
echo "If you generated an SSH key, add the public key to GitHub and test:"
echo "  ssh -T git@github.com"

exit 0git -v
