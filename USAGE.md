# Git Filter Repo (Rust Implementation) - Example Usage

## Basic Commands

### Analyze Repository
```bash
# Analyze the repository and generate a report
git filter-repo analyze
```

### Filter Operations (Original Functionality)
All the original functionality is now under the `filter` subcommand:

#### Path Filtering
```bash
# Include only specific paths
git filter-repo filter --path src/

# Include multiple paths
git filter-repo filter --path src/ --path docs/

# Include paths matching glob patterns
git filter-repo filter --path-glob "*.txt"

# Include paths matching regex patterns
git filter-repo filter --path-regex "^tests/"

# Exclude specific paths (invert selection)
git filter-repo filter --path secret/ --invert-paths
```

#### Path Renaming
```bash
# Rename a path
git filter-repo filter --path-rename "old-name:new-name"

# Multiple renames
git filter-repo filter --path-rename "old1:new1" --path-rename "old2:new2"
```

#### Subdirectory Filtering
```bash
# Extract a subdirectory and make it the root
git filter-repo filter --subdirectory-filter mymodule

# Move the entire repo under a subdirectory
git filter-repo filter --to-subdirectory-filter myproject
```

#### Content Replacement
```bash
# Create a file with replacement rules
cat > replacements.txt << 'EOF'
password==>***REDACTED***
secret-key==>***REDACTED***
EOF

# Apply content replacements
git filter-repo filter --replace-text replacements.txt
```

#### Size-based Filtering
```bash
# Remove files larger than 10MB
git filter-repo filter --strip-blobs-bigger-than 10M

# Remove files larger than 1GB
git filter-repo filter --strip-blobs-bigger-than 1G
```

#### Tag Renaming
```bash
# Rename tags (e.g., add prefix)
git filter-repo filter --tag-rename ':prefix-'

# Replace tag prefix
git filter-repo filter --tag-rename 'old-prefix:new-prefix'
```

### Extended Functionality (Contrib Tools as Subcommands)

#### Clean Ignore
Delete files from history which match current gitignore rules:

```bash
# Clean files matching .gitignore rules
git filter-repo clean-ignore --force

# Dry run to see what would be removed
git filter-repo clean-ignore --dry-run
```

#### Lint History
Run a command on all non-binary files in history (for linting, etc.):

```bash
# Run a linter on all files in history
git filter-repo lint-history "eslint {}"

# Run on all commits in history
git filter-repo lint-history --all "pylint {}"
```

#### Insert Beginning
Add a new file to the beginning of history:

```bash
# Add a license file to the beginning of history
git filter-repo insert-beginning LICENSE

# With custom message
git filter-repo insert-beginning --message "Add LICENSE" LICENSE
```

#### Signed Off By
Add Signed-off-by tags to commits:

```bash
# Add Signed-off-by to recent commits
git filter-repo signed-off-by --email "user@example.com"

# Add to specific range
git filter-repo signed-off-by --range "HEAD~5..HEAD" --email "user@example.com"
```

### Dry Run
```bash
# Test the filter without making changes
git filter-repo filter --path src/ --dry-run
```

### Combined Usage
```bash
# Complex example: Extract src/, rename it to my-source/, and remove large files
git filter-repo filter \
  --path src/ \
  --path-rename "src/:my-source/" \
  --strip-blobs-bigger-than 50M \
  --force
```

## Common Options

For the `filter` subcommand:
- `--force, -f`: Override safety checks (use with caution!)
- `--dry-run`: Show what would be done without making changes
- `--quiet`: Suppress output
- `--preserve-commit-hashes`: Don't update commit references in messages
- `--prune-empty auto`: Control removal of empty commits
- `--mailmap FILENAME`: Use mailmap file for name/email rewriting
- `--sensitive-data-removal`: Handle sensitive data removal workflows

For contrib subcommands:
- `clean-ignore`, `lint-history`, `insert-beginning`, `signed-off-by` all support common options like `--force`, `--dry-run`, and `--quiet`.

## Advanced Content Replacement Rules

Create a file with various replacement patterns:

```bash
cat > advanced-replacements.txt << 'EOF'
# Literal text replacement
api-key==>***REDACTED***

# Regular expression replacement
regex:secret-[a-zA-Z0-9]{32}==>***SECRET***

# Glob pattern replacement
glob:password_*==>***PASSWORD***

# Line-based replacement with custom replacement text
username==>user@example.com==>***ANONYMIZED_USER***
EOF

git filter-repo filter --replace-text advanced-replacements.txt
```