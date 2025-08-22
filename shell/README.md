# Shell Configuration

Shell configuration files (bash, zsh, etc.).

## Files

Place your shell configuration files here:

- `bashrc` -> `~/.bashrc`
- `zshrc` -> `~/.zshrc` 
- `profile` -> `~/.profile`
- `aliases` -> sourced by shell configs for common aliases
- `exports` -> sourced by shell configs for environment variables

## Example Structure

```bash
# In your bashrc/zshrc, source additional files:
source "$HOME/dotfiles/shell/aliases"
source "$HOME/dotfiles/shell/exports"
```
