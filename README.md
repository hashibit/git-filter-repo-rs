# Git Filter Repo (Rust Implementation)

A Rust implementation of the popular `git-filter-repo` tool for rewriting Git repository history.

## Features

- **Subcommand Architecture**: Organized with clear subcommands for different operations
- **Core Filter Operations**: Complete implementation of the main git-filter-repo functionality:
  - Path filtering: Include/exclude specific paths, globs, or regex patterns
  - Path renaming: Rename files and directories during the filtering process
  - Content filtering: Replace text content using literal, regex, or glob patterns
  - Size-based filtering: Remove files larger than a specified size
  - Tag renaming: Rename tags during the filtering process
  - History analysis: Analyze repository history and generate reports
- **Contrib Demos**: Additional tools reimplemented as subcommands:
  - `clean-ignore`: Delete files from history that match current gitignore rules
  - `lint-history`: Run a command on all non-binary files in history (for linting, etc.)
  - `insert-beginning`: Add a new file to the beginning of history
  - `signed-off-by`: Add Signed-off-by tags to commits

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
./git-filter-repo filter --path src/ --invert-paths
```

## Usage

### Analyze Repository

Generate a report analyzing the repository:

```bash
git filter-repo analyze --report-dir ./analysis-report
```

### Filter Repository

Apply filters to rewrite repository history:

```bash
# Filter to include only specific paths
git filter-repo filter --path src/

# Filter with glob patterns
git filter-repo filter --path-glob "*.txt"

# Filter with regex patterns
git filter-repo filter --path-regex "^docs/"

# Rename paths
git filter-repo filter --path-rename "old/path:new/path"

# Remove large files
git filter-repo filter --strip-blobs-bigger-than 5M

# Replace content
git filter-repo filter --replace-text replacements.txt
```

### Clean Files Matching Gitignore

Remove files from history that match current gitignore rules:

```bash
git filter-repo clean-ignore
```

### Run Linting on History

Execute a command on all non-binary files in history:

```bash
# Run a linter on all files in history
git filter-repo lint-history my-linter-tool --arg value

# Run a custom script
git filter-repo lint-history ./check-formatting.sh
```

### Insert File at Beginning

Add a new file to the beginning of history:

```bash
git filter-repo insert-beginning --file-path LICENSE --content "MIT License..." --message "Add license"
```

### Add Signed-off-by Tags

Add Signed-off-by lines to commit messages:

```bash
git filter-repo signed-off-by --signature "John Doe <john@example.com>"
```

### Options

- `--invert-paths`: Invert the selection of files from the specified path options
- `--use-base-name`: Match on file base name instead of full path
- `--subdirectory-filter DIR`: Extract history of a subdirectory and treat as project root
- `--to-subdirectory-filter DIR`: Treat project root as if under specified directory
- `--tag-rename OLD:NEW`: Rename tags
- `--force`: Force rewriting even if not in a fresh clone
- `--dry-run`: Perform a dry run without changing the repository
- `--quiet`: Suppress output
- `--prune-empty WHEN`: Control pruning of empty commits
- `--preserve-commit-hashes`: Preserve commit hashes in commit messages

## Build Dependencies

- Rust (1.70 or later)
- Cargo
- Git development headers (for git2 crate)

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