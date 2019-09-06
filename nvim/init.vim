let g:airline_powerline_fonts = 1
let g:airline_theme = 'dracula'

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
set wildignore+=*/tmp/*,*.so,*.meta,*.dll

let mapleader = " "
set timeoutlen=200

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
call plug#end()

set background=dark
colorscheme palenight


let FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'

let g:ale_sign_column_always=1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

set completeopt=longest,menuone,preview
set previewheight=5
let g:OmniSharp_highlight_types = 2

let g:OmniSharp_server_stdio = 1
augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Update the highlighting whenever leaving insert mode
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

    autocmd BufWritePre *.cs call OmniSharp#CodeFormat()

    " Alternatively, use a mapping to refresh highlighting for the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader>f :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Clean up NERDTree
let NERDTreeIgnore=['\.meta$', '\.dll$', '\.[aA]sset$', '\.prefab']

" Enable snippet completion
let g:OmniSharp_want_snippet=1
let g:UltiSnipsExpandTrigger="<C-p><tab>"



" Configure asyncomplete to not pop up by default
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Keyboard mappings to make life sane
nmap s <Plug>(easymotion-overwin-f2)
nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <Leader>ne :ALENextWrap<CR>
nnoremap <Leader>pe :ALEPreviousWrap<CR>

nnoremap <Leader>fn :ALENextWrap<CR>:OmniSharpGetCodeActions<CR>
nnoremap <Leader>fp :ALEPreviousWrap<CR>:OmniSharpGetCodeActions<CR>

nnoremap <Leader><Leader>l <C-W><C-L>
nnoremap <Leader><Leader>h <C-W><C-H>
nnoremap <Leader><Leader>j <C-W><C-J>
nnoremap <Leader><Leader>k <C-W><C-K>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>c :bdelete<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <CR> :noh<CR><CR>
