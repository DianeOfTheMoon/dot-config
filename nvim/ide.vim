autocmd CursorHold * silent call CocActionAsync('highlight')

" Vista default config
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1

" Global coc config
let g:coc_extension_root = $XDG_DATA_HOME.'/coc'
let g:coc_snippet_next = "\<TAB>"
let g:coc_snippet_prev = "\<S-TAB>"


autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Remap keys for gotos
nmap <silent> ;d <Plug>(coc-definition)
nmap <silent> ;y <Plug>(coc-type-definition)
nmap <silent> ;i <Plug>(coc-implementation)
nmap <silent> ;r <Plug>(coc-references)

nmap <silent> zj <Plug>(coc-diagnostic-next)
nmap <silent> zk <Plug>(coc-diagnostic-prev)

nmap <leader>f  <Plug>(coc-codeaction)
xmap f  <Plug>(coc-codeaction-selected)
nmap f  <Plug>(coc-codeaction-selected)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <TAB> :Vista finder<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    let retVal = !col || getline('.')[col - 1]  =~ '\s'
    return retVal
endfunction

imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-g>u\<CR>"

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')

" floating fzf
highlight FZFFinder guibg=Gray guifg=Purple
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

  function! FloatingFZF()
    let height = &lines
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)
    let col_offset = &columns / 10
    let opts = {
          \ 'relative': 'editor',
          \ 'row': 1,
          \ 'col': col + col_offset,
          \ 'width': width * 2 / 1,
          \ 'height': height / 2,
          \ 'style': 'minimal'
          \ }
    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhl', 'FZFFinder')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif
