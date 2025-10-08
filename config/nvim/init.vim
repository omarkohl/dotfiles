" Omar's Neovim Configuration
" ===========================
" This is a symlink target for both vim and neovim

" Source the main vim configuration
source ~/.config/vim/vimrc

" Neovim-specific settings (if any)
if has('nvim')
    " Neovim specific configurations can go here
    
    " Use true colors
    set termguicolors
    
    " Better default for inccommand
    set inccommand=split
endif
