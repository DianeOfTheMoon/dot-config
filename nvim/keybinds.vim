" Keyboard mappings to make life sane
let mapleader = " "
set timeoutlen=200

nmap s <Plug>(easymotion-overwin-f2)
nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <Leader><Leader>l <C-W><C-L>
nnoremap <Leader><Leader>h <C-W><C-H>
nnoremap <Leader><Leader>j <C-W><C-J>
nnoremap <Leader><Leader>k <C-W><C-K>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>c :bdelete<CR>
nnoremap <Leader>p :FZF<CR>



" Use <TAB> to select the popup menu:
let g:UltiSnipsExpandTrigger="<c-l>"

function! s:check_back_space() abort
    let col = col('.') - 1
    let retVal = !col || getline('.')[col - 1]  =~ '\s'
    return retVal
endfunction

imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ "\<C-x><C-o>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

autocmd User UltiSnipsEnterFirstSnippet imap <silent> <TAB> <C-R>=UltiSnips#ExpandSnippetOrJump()<cr>
autocmd User UltiSnipsExitLastSnippet imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ "\<C-x><C-o>"
