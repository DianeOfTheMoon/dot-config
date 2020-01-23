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
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'honza/vim-snippets'
  Plug 'wellle/targets.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'bfrg/vim-cpp-modern'
  Plug 'liuchengxu/vista.vim'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'moll/vim-bbye'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile' }
  Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile' }
call plug#end()

source $CONFIG_DIR/display.vim
source $CONFIG_DIR/keybinds.vim
source $CONFIG_DIR/navigation.vim
source $CONFIG_DIR/ide.vim
