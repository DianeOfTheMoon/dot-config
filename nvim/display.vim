set background=dark
set termguicolors
colorscheme palenight
let g:palenight_terminal_italics=1

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"

set completeopt=longest,menuone,preview
set previewheight=5
set cmdheight=2
set title

set updatetime=300
set autoread
au BufEnter,FocusGained * :checktime
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set hidden
set splitbelow
set splitright
set signcolumn=yes
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2

let g:airline_powerline_fonts = 1
let g:airline_theme = 'palenight'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

highlight Comment   gui=italic
