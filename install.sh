#!/bin/bash

# Install script for git-filter-repo Rust implementation

set -e

echo "Installing git-filter-repo Rust implementation..."

# Build the project
echo "Building the project..."
cargo build --release

# Copy the binary to a location in PATH
BINARY_PATH="/usr/local/bin/git-filter-repo"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # On macOS, we might need to use a different path or ask for sudo
    if [ -w "/usr/local/bin" ]; then
        cp target/release/git-filter-repo "$BINARY_PATH"
        echo "Installed git-filter-repo to $BINARY_PATH"
    else
        echo "Need sudo to install to /usr/local/bin:"
        sudo cp target/release/git-filter-repo "$BINARY_PATH"
        echo "Installed git-filter-repo to $BINARY_PATH"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -w "/usr/local/bin" ]; then
        cp target/release/git-filter-repo "$BINARY_PATH"
        echo "Installed git-filter-repo to $BINARY_PATH"
    else
        echo "Need sudo to install to /usr/local/bin:"
        sudo cp target/release/git-filter-repo "$BINARY_PATH"
        echo "Installed git-filter-repo to $BINARY_PATH"
    fi
else
    echo "Unsupported OS. Please copy target/release/git-filter-repo to a location in your PATH manually."
    exit 1
fi

echo "Installation complete!"
echo ""
echo "You can now use git-filter-repo as a git subcommand:"
echo "  git filter-repo --help"
echo "  git filter-repo analyze"
echo "  git filter-repo filter --path src/ --invert-paths"