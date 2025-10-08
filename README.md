# Dotfiles

Personal configuration files and scripts.

## Structure

```
dotfiles/
├── bin/              # Executable scripts and tools
│   ├── stackpr       # Example script
│   └── vim-plugins   # Vim plugin management script
├── shell/            # Shell configuration (bash, zsh, etc.)
├── git/              # Git configuration
├── config/           # Application configs (mirrors ~/.config structure)
│   ├── vim/          # Vim configuration with plug.vim
│   └── nvim/         # Neovim configuration
├── install.sh        # Installation script
└── README.md         # This file
```

## Installation

```bash
git clone https://github.com/omarkohl/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer will:

1. Create symlinks for all configurations
2. Install vim-plug automatically
3. Set up vim and neovim configurations
4. Install scripts to `~/.local/bin`

## Vim Configuration

The vim configuration includes:

- **Plugin manager**: vim-plug (auto-installed)
- **File navigation**: NERDTree, FZF fuzzy finder
- **Git integration**: vim-fugitive, vim-gitgutter
- **Code editing**: vim-surround, vim-commentary
- **Linting**: ALE with language-specific linters
- **Themes**: Gruvbox, One Dark

### Managing Vim Plugins

After installation, you can manage vim plugins using the included script:

```bash
# Install all plugins
vim-plugins install

# Update all plugins
vim-plugins update

# Clean unused plugins
vim-plugins clean
```

Or manually in vim:
```vim
:PlugInstall    " Install plugins
:PlugUpdate     " Update plugins
:PlugClean      " Remove unused plugins
```

### Key Mappings

- **Leader key**: `,` (comma)
- `Ctrl+n` - Toggle file explorer
- `Ctrl+p` - Fuzzy find files
- `Ctrl+f` - Search in files
- `,w` - Save file
- `,q` - Quit

See `config/vim/README.md` for complete documentation.
