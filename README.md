# Git Filter Repo (Rust Implementation)

A Rust implementation of the popular `git-filter-repo` tool for rewriting Git repository history. This version maintains complete compatibility with the original Python version's command-line interface and extends it with additional subcommands.

## Features

- **Complete Compatibility**: Maintains the exact same command-line interface as the original Python version
- **Single Executable**: All functionality in a single, fast Rust binary
- **Path Filtering**: Include or exclude specific paths, globs, or regex patterns
- **Path Renaming**: Rename files and directories during the filtering process
- **Content Filtering**: Replace text content using literal, regex, or glob patterns
- **Size-Based Filtering**: Remove files larger than a specified size
- **Tag Renaming**: Rename tags during the filtering process
- **History Analysis**: Analyze repository history and generate reports
- **Extended Functionality**: Additional subcommands like clean-ignore, lint-history, insert-beginning, and signed-off-by

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

### As a Git Subcommand

Once installed, you can use it as a git subcommand:

```bash
# Filter repository
git filter-repo --path src/

# Analyze repository
git filter-repo analyze

# Clean files matching gitignore rules
git filter-repo clean-ignore --force
```

### Direct Usage

```bash
# Filter repository with path
git-filter-repo filter --path src/

# Analyze repository history
git-filter-repo analyze --report-dir ./analysis-report

# Filter with glob patterns
git-filter-repo filter --path-glob "*.txt"

# Filter with regex patterns
git-filter-repo filter --path-regex "^docs/"

# Exclude specific paths (invert selection)
git-filter-repo filter --path secret/ --invert-paths

# Rename paths
git-filter-repo filter --path-rename "old/path:new/path"

# Remove large files
git-filter-repo filter --strip-blobs-bigger-than 5M

# Replace content
git-filter-repo filter --replace-text replacements.txt

# Extract a subdirectory and make it the root
git-filter-repo filter --subdirectory-filter mymodule

# Move the entire repo under a subdirectory
git-filter-repo filter --to-subdirectory-filter myproject

# Clean files matching gitignore rules
git-filter-repo clean-ignore --force

# Run lint command on all files in history
git-filter-repo lint-history "eslint {}"

# Add a file to the beginning of history
git-filter-repo insert-beginning myfile.txt

# Add Signed-off-by tags to commits
git-filter-repo signed-off-by --email "user@example.com"
```

### Subcommands

- `analyze`: Analyze repository history and create a report
- `filter`: Filter repository history with various options (original functionality)
- `clean-ignore`: Delete files from history which match current gitignore rules
- `lint-history`: Run a command on all non-binary files in history (for linting, etc.)
- `insert-beginning`: Add a new file to the beginning of history
- `signed-off-by`: Add Signed-off-by tags to commits

### Common Options

For the `filter` subcommand:
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