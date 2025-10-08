#!/bin/bash
set -o nounset
set -o pipefail
set -o errexit

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

backup_if_exists() {
    local file="$1"
    if [[ -e "$file" || -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
        warn "Backed up existing $file to $BACKUP_DIR/"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [[ ! -e "$source" ]]; then
        error "Source file $source does not exist"
        return 1
    fi
    
    backup_if_exists "$target"
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    info "Linked $source -> $target"
}

main() {
    info "Installing dotfiles from $DOTFILES_DIR"
    
    # Install scripts to ~/.local/bin
    info "Installing scripts..."
    mkdir -p "$HOME/.local/bin"
    
    for script in "$DOTFILES_DIR/bin"/*; do
        if [[ -f "$script" && -x "$script" ]]; then
            info "Installing script ${script}"
            script_name=$(basename "$script")
            create_symlink "$script" "$HOME/.local/bin/$script_name"
        fi
    done
    
    # Install shell configs
    info "Installing shell configurations..."
    
    # Example: if you have shell/bashrc
    if [[ -f "$DOTFILES_DIR/shell/bashrc" ]]; then
        create_symlink "$DOTFILES_DIR/shell/bashrc" "$HOME/.bashrc"
    fi
    
    # Example: if you have shell/zshrc
    if [[ -f "$DOTFILES_DIR/shell/zshrc" ]]; then
        create_symlink "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
    fi
    
    # Install git config
    info "Installing git configuration..."
    if [[ -f "$DOTFILES_DIR/git/gitconfig" ]]; then
        create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
    fi
    
    # Install vim configuration
    info "Installing vim configuration..."
    if [[ -f "$DOTFILES_DIR/config/vim/vimrc" ]]; then
        # Create vim config directory symlink
        create_symlink "$DOTFILES_DIR/config/vim" "$HOME/.config/vim"
        
        # Create traditional vim config symlink for compatibility
        create_symlink "$DOTFILES_DIR/config/vim/vim_vimrc" "$HOME/.vimrc"
        
        # Install vim-plug if not present
        if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
            info "Installing vim-plug..."
            mkdir -p "$HOME/.vim/autoload"
            curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            info "vim-plug installed successfully"
        fi
    fi
    
    # Install application configs
    info "Installing application configurations..."
    if [[ -d "$DOTFILES_DIR/config" ]]; then
        for config_dir in "$DOTFILES_DIR/config"/*; do
            if [[ -d "$config_dir" ]]; then
                config_name=$(basename "$config_dir")
                # Skip vim config as it's handled specially above
                if [[ "$config_name" != "vim" ]]; then
                    create_symlink "$config_dir" "$HOME/.config/$config_name"
                fi
            fi
        done
    fi
    
    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        warn "~/.local/bin is not in your PATH"
        warn "Add this to your shell config:"
        warn "export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
    
    # Check for jj email configuration
    if [[ -f "$DOTFILES_DIR/config/jj/config.toml" ]] && \
            [[ ! -f "$HOME/.config/jj/conf.d/local.toml" ]]; then
        warn "jj conf.d/local.toml not found"
        warn "Copy \"$HOME/.config/jj/conf.d/local.toml.example\"" \
            "to \"$HOME/.config/jj/conf.d/local.toml\" and set your email"
    fi
    
    info "Dotfiles installation complete!"
    
    if [[ -d "$BACKUP_DIR" ]]; then
        info "Backups created in $BACKUP_DIR"
    fi
}

main "$@"
