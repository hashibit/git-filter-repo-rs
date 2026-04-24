#!/bin/bash

# Install script for git-filter-repo (Rust implementation)
# This installs the Rust binary that provides git-filter-repo functionality with subcommands

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if cargo is installed
if ! command -v cargo &> /dev/null; then
    print_error "Cargo is not installed. Please install Rust from https://rustup.rs/"
    exit 1
fi

print_status "Building git-filter-repo Rust binary..."
cargo build --release

BINARY_PATH="target/release/git-filter-repo"

if [ ! -f "$BINARY_PATH" ]; then
    print_error "Build failed: $BINARY_PATH not found"
    exit 1
fi

# Determine installation directory
INSTALL_DIR="/usr/local/bin"
if [ "$EUID" -eq 0 ]; then
    # Running as root, use /usr/local/bin
    INSTALL_DIR="/usr/local/bin"
elif [ -w "/usr/local/bin" ]; then
    # Can write to /usr/local/bin without root
    INSTALL_DIR="/usr/local/bin"
else
    # Cannot write to /usr/local/bin, use ~/bin
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    print_warning "Installing to $INSTALL_DIR (not in standard system PATH)"
    print_warning "Consider adding $INSTALL_DIR to your PATH in ~/.bashrc or ~/.zshrc"
fi

print_status "Installing to $INSTALL_DIR..."
sudo cp "$BINARY_PATH" "$INSTALL_DIR/"

# Verify installation
if command -v git-filter-repo &> /dev/null; then
    print_status "Installation successful!"
    print_status "You can now use git-filter-repo as:"
    echo "  - Direct binary: git-filter-repo --help"
    echo "  - Git subcommand: git filter-repo --help"
    echo ""
    echo "Available subcommands:"
    echo "  - git filter-repo filter    : Original git-filter-repo functionality"
    echo "  - git filter-repo analyze   : Analyze repository history"
    echo "  - git filter-repo clean-ignore    : Delete files matching .gitignore rules"
    echo "  - git filter-repo lint-history    : Run commands on files in history"
    echo "  - git filter-repo insert-beginning: Add files to beginning of history"
    echo "  - git filter-repo signed-off-by   : Add Signed-off-by tags to commits"
else
    print_error "Installation verification failed"
    exit 1
fi