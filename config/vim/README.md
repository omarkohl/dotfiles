# Vim Configuration

This directory contains my vim and neovim configuration using vim-plug for plugin management.

## Files

- `vimrc` - Main vim configuration file
- `vim_vimrc` - Compatibility file that sources the main config (symlinked to `~/.vimrc`)
- `../nvim/init.vim` - Neovim configuration that sources the main vim config

## Features

### Plugins Included

- **tpope/vim-sensible** - Sensible default settings
- **tpope/vim-surround** - Easily surround text with quotes, brackets, etc.
- **tpope/vim-commentary** - Easy commenting with `gcc`
- **tpope/vim-fugitive** - Git integration
- **tpope/vim-unimpaired** - Handy bracket mappings
- **preservim/nerdtree** - File explorer (`Ctrl+n`)
- **junegunn/fzf** + **fzf.vim** - Fuzzy finder (`Ctrl+p` for files, `Ctrl+f` for text search)
- **dense-analysis/ale** - Async linting and syntax checking
- **sheerun/vim-polyglot** - Language pack for syntax highlighting
- **vim-airline** - Enhanced status line
- **airblade/vim-gitgutter** - Git diff indicators in the gutter
- **gruvbox** - Colorscheme

### Key Features

- **Automatic plugin installation** - vim-plug will be installed automatically
- **Smart indentation** - 4 spaces by default, 2 for web files (yaml, json, js, html, css)
- **Backup and undo files** - Persistent undo and organized backup files
- **Search improvements** - Incremental search with smart case matching
- **Visual improvements** - Line numbers, syntax highlighting, current line highlighting

### Key Mappings

- **Leader key**: `,` (comma)
- **File navigation**:
  - `Ctrl+n` - Toggle NERDTree
  - `Ctrl+p` - Fuzzy find files
  - `Ctrl+f` - Fuzzy search text in files
- **Buffer management**:
  - `,b` - List buffers
  - `,n` - Next buffer
  - `,p` - Previous buffer
- **Quick actions**:
  - `,w` - Save file
  - `,q` - Quit
  - `,x` - Save and quit
  - `,<space>` - Clear search highlighting
- **Split navigation**:
  - `Ctrl+h/j/k/l` - Navigate between splits

## Installation

The vim configuration is automatically installed when you run the main dotfiles installer:

```bash
./install.sh
```

This will:

1. Create symlinks to the appropriate locations
2. Install vim-plug if not present
3. Set up the plugin directory structure

## Manual Plugin Installation

After installation, open vim and run:

```vim
:PlugInstall
```

This will install all the plugins defined in the configuration.

## Updating Plugins

To update all plugins:

```vim
:PlugUpdate
```

## Customization

### Local Configuration

If you want to add local customizations without modifying the main config, create:

- `~/.vimrc.local` - Will be automatically sourced if it exists

### Adding New Plugins

Edit the `vimrc` file and add new plugins between the `call plug#begin()` and `call plug#end()` lines:

```vim
Plug 'author/plugin-name'
```

Then run `:PlugInstall` in vim.

### Removing Plugins

1. Remove or comment out the plugin line in `vimrc`
2. Run `:PlugClean` in vim to remove unused plugins

## Troubleshooting

### Plugin Issues

If you have issues with plugins:

1. Check if vim-plug is installed: `:PlugStatus`
2. Reinstall plugins: `:PlugInstall`
3. Clean unused plugins: `:PlugClean`

### Colorscheme Issues

If the colorscheme doesn't load properly:

1. Ensure your terminal supports 256 colors or true colors
2. The config falls back to the default colorscheme if gruvbox isn't available

### ALE Linting

For linting to work properly, you may need to install language-specific linters:

```bash
# Python
pip install flake8 pylint

# JavaScript
npm install -g eslint

# Go
go install golang.org/x/lint/golint@latest

# Rust
rustup component add rust-analyzer
```
