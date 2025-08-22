# Scripts

Executable scripts and command-line tools.

## stackpr

Create GitHub stacked PRs from Jujutsu changes.

**Dependencies:**
- Jujutsu (`jj`)
- GitHub CLI (`gh`)

**Usage:**
```bash
stackpr <change_id> [-B base_branch] [--dry-run] [--add-reviewer reviewers]
```

**Examples:**
```bash
# Create stacked PRs for all changes from main to abc123
stackpr abc123

# Dry run to see what would happen
stackpr abc123 --dry-run

# Target a different base branch
stackpr abc123 -B develop

# Add reviewers
stackpr abc123 --add-reviewer "user1,user2"
```
