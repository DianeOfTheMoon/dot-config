let $CONFIG_DIR = fnamemodify($MYVIMRC, ':p:h')
filetype plugin indent on

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'easymotion/vim-easymotion'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'DianeOfTheMoon/omnisharp-vim'
  Plug 'dense-analysis/ale'
  Plug 'wellle/targets.vim'
call plug#end()

source $CONFIG_DIR/display.vim
source $CONFIG_DIR/keybinds.vim
source $CONFIG_DIR/navigation.vim
source $CONFIG_DIR/ide.vim
