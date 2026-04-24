# Git Filter Repo (Rust Implementation)

A Rust implementation of the popular `git-filter-repo` tool for rewriting Git repository history. This version maintains complete compatibility with the original Python version's command-line interface.

## Features

- **Complete Compatibility**: Maintains the exact same command-line interface as the original Python version
- **Single Executable**: All functionality in a single, fast Rust binary
- **Path Filtering**: Include or exclude specific paths, globs, or regex patterns
- **Path Renaming**: Rename files and directories during the filtering process
- **Content Filtering**: Replace text content using literal, regex, or glob patterns
- **Size-Based Filtering**: Remove files larger than a specified size
- **Tag Renaming**: Rename tags during the filtering process
- **Advanced Options**: Support for mailmap, sensitive data removal, pruning options, and more
- **History Analysis**: Analyze repository history and generate reports

## Installation

To build and install the tool:

```bash
# Clone the repository
git clone <your-repo-url>
cd git-filter-repo-rs

# Build the binary
cargo build --release

# Install to a location in your PATH
sudo cp target/release/git-filter-repo /usr/local/bin/
```

Alternatively, you can run the tool directly:

```bash
# Build and run without installing
./git-filter-repo --analyze
```

## Usage

### Analyze Repository

Generate a report analyzing the repository:

```bash
git filter-repo --analyze --report-dir ./analysis-report
```

### Filter Repository

Apply filters to rewrite repository history:

```bash
# Filter to include only specific paths
git filter-repo --path src/

# Filter with glob patterns
git filter-repo --path-glob "*.txt"

# Filter with regex patterns
git filter-repo --path-regex "^docs/"

# Exclude specific paths (invert selection)
git filter-repo --path secret/ --invert-paths

# Rename paths
git filter-repo --path-rename "old/path:new/path"

# Remove large files
git filter-repo --strip-blobs-bigger-than 5M

# Replace content
git filter-repo --replace-text replacements.txt

# Extract a subdirectory and make it the root
git filter-repo --subdirectory-filter mymodule

# Move the entire repo under a subdirectory
git filter-repo --to-subdirectory-filter myproject
```

### Options

- `--invert-paths`: Invert the selection of files from the specified path options
- `--use-base-name`: Match on file base name instead of full path
- `--subdirectory-filter DIR`: Extract history of a subdirectory and treat as project root
- `--to-subdirectory-filter DIR`: Treat project root as if under specified directory
- `--tag-rename OLD:NEW`: Rename tags
- `--force, -f`: Force rewriting even if not in a fresh clone
- `--dry-run`: Perform a dry run without changing the repository
- `--quiet`: Suppress output
- `--prune-empty WHEN`: Control pruning of empty commits
- `--preserve-commit-hashes`: Preserve commit hashes in commit messages
- `--mailmap FILENAME`: Use specified mailmap file for name/email rewriting
- `--sensitive-data-removal`: Handle sensitive data removal workflows

## Build Dependencies

- Rust (1.70 or later)
- Cargo

## Development

To build for development:

```bash
cargo build
```

To run tests:

```bash
cargo test
```

To build for production:

```bash
cargo build --release
```

## License

MIT License