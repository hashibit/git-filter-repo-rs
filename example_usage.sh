#!/bin/bash

# Example usage of the git-filter-repo Rust binary

echo "Testing git-filter-repo Rust implementation"
echo ""

echo "1. Show version:"
./target/release/git-filter-repo --version
echo ""

echo "2. Show help:"
./target/release/git-filter-repo --help | head -20
echo ""

echo "3. Example commands (these would work in a git repository):"
echo "   ./target/release/git-filter-repo --analyze"
echo "   ./target/release/git-filter-repo --path src/"
echo "   ./target/release/git-filter-repo --path-glob \"*.txt\" --dry-run"
echo "   ./target/release/git-filter-repo --replace-text replacements.txt"
echo ""

echo "To install globally so you can use 'git filter-repo':"
echo "1. Copy the binary to a directory in your PATH:"
echo "   sudo cp ./target/release/git-filter-repo /usr/local/bin/"
echo ""
echo "2. Or create a symlink:"
echo "   ln -s $(pwd)/target/release/git-filter-repo ~/bin/git-filter-repo  # if ~/bin is in your PATH"
echo ""
echo "After installation, you can run from any git repository:"
echo "   git filter-repo --analyze"
echo "   git filter-repo --path src/ --path docs/"