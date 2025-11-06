# Claude User Memory

This file contains information about my preferences, workflows, and important context for Claude.

## Communication Style
- Keep plans, documentation, and commit messages very concise by default
- Be brief and to the point

## Planning
- Plans should end with an "Open Questions" section for the user to resolve
- Skip this section if there are no open questions

## Version Control (jj/jujutsu)
- Use `jj` (jujutsu) for version control operations
- Primary commands: `jj commit -m "message"` and `jj squash` for modifying previous changes
- Each change/commit must be a semantically coherent unit doing one thing
- Commit messages: as short as possible, as long as necessary, focus on WHY
- Follow conventional commit format (e.g., `feat:`, `fix:`, `refactor:`, etc.)

## GitHub Integration
- Use `gh` command line tool for all GitHub interactions

## Pre-commit Workflow
Before committing, always run:
1. Unit tests
2. Linting
3. Formatting

