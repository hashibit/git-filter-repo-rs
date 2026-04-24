# Git Filter Repo (Rust Implementation) - Example Usage

## Basic Commands

### Analyze Repository
```bash
# Analyze the repository and generate a report
git filter-repo --analyze
```

### Filter Operations

#### Path Filtering
```bash
# Include only specific paths
git filter-repo --path src/

# Include multiple paths
git filter-repo --path src/ --path docs/

# Include paths matching glob patterns
git filter-repo --path-glob "*.txt"

# Include paths matching regex patterns
git filter-repo --path-regex "^tests/"

# Exclude specific paths (invert selection)
git filter-repo --path secret/ --invert-paths
```

#### Path Renaming
```bash
# Rename a path
git filter-repo --path-rename "old-name:new-name"

# Multiple renames
git filter-repo --path-rename "old1:new1" --path-rename "old2:new2"
```

#### Subdirectory Filtering
```bash
# Extract a subdirectory and make it the root
git filter-repo --subdirectory-filter mymodule

# Move the entire repo under a subdirectory
git filter-repo --to-subdirectory-filter myproject
```

#### Content Replacement
```bash
# Create a file with replacement rules
cat > replacements.txt << 'EOF'
password==>***REDACTED***
secret-key==>***REDACTED***
EOF

# Apply content replacements
git filter-repo --replace-text replacements.txt
```

#### Size-based Filtering
```bash
# Remove files larger than 10MB
git filter-repo --strip-blobs-bigger-than 10M

# Remove files larger than 1GB
git filter-repo --strip-blobs-bigger-than 1G
```

#### Tag Renaming
```bash
# Rename tags (e.g., add prefix)
git filter-repo --tag-rename ':prefix-'

# Replace tag prefix
git filter-repo --tag-rename 'old-prefix:new-prefix'
```

### Dry Run
```bash
# Test the filter without making changes
git filter-repo --path src/ --dry-run
```

### Combined Usage
```bash
# Complex example: Extract src/, rename it to my-source/, and remove large files
git filter-repo \
  --path src/ \
  --path-rename "src/:my-source/" \
  --strip-blobs-bigger-than 50M \
  --force
```

## Common Options

- `--force, -f`: Override safety checks (use with caution!)
- `--dry-run`: Show what would be done without making changes
- `--quiet`: Suppress output
- `--preserve-commit-hashes`: Don't update commit references in messages
- `--prune-empty auto`: Control removal of empty commits
- `--mailmap FILENAME`: Use mailmap file for name/email rewriting
- `--sensitive-data-removal`: Handle sensitive data removal workflows

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

git filter-repo --replace-text advanced-replacements.txt
```